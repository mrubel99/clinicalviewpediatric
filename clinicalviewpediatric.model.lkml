connection: "bp_vinylbluepointdev"

include: "/Clinical_Views/*.view.lkml"
#include: "*.dashboard"

##DEV CODE

access_grant: clinicalviewadmin{
  user_attribute: clincalview_is_explore_admin
  allowed_values: ["Yes"]
}

datagroup: studydetail_change {
  sql_trigger: SELECT SUM(TotalSpend) FROM dbo.CacheBPfctFacilityStudyDetail;;
  max_cache_age: "720 hours"
}
datagroup: podetail_change {
  sql_trigger: SELECT SUM(TotalCostBase) FROM dbo.CacheBPfctPODetail;;
  max_cache_age: "720 hours"
}
datagroup: no_cache{
  max_cache_age: "0 seconds"
}



explore: bp_studydetail {
  label: "Pedi ClinicalView Data Model"
  group_label: "Pedi ClinicalView"
  description: "Clinical View Project, PO and Savings Data"
  persist_with: no_cache
  #studydetail_change


  fields: [ALL_FIELDS*
    ,-bp_facilities.facility_exclusions*
    ,-bp_categories.category_exclusions*
    ,-bp_studydetail.studydetail_exclusions*
    ,-bp_podetail.bp_podetail_exclusions*
  ]

  join: bp_categories {
    type: left_outer
    sql_on: ${bp_categories.study_skey} = ${bp_studydetail.study_skey} ;;
    relationship: one_to_many
  }

  join: bp_facilities {
    type: left_outer
    sql_on: ${bp_facilities.facility_skey} = ${bp_studydetail.facility_skey};;
    relationship: one_to_many
  }

  join: bp_podetail {
    type: left_outer
    sql_on: ${bp_podetail.analysis_skey} = ${bp_studydetail.study_skey}
          AND ${bp_podetail.member_skey} = ${bp_studydetail.facility_skey}
          AND ${bp_podetail.raw_po_end_date} = ${bp_studydetail.raw_study_end_date};;
    relationship: many_to_many
  }

  join: analysis_desi_key_master{
    type: left_outer
    sql_on: ${analysis_desi_key_master.analysis_skey} = ${bp_podetail.analysis_skey}
          AND ${analysis_desi_key_master.data_designation_skey} = ${bp_podetail.data_designation_skey}
          AND ${analysis_desi_key_master.product_key_skey} = ${bp_podetail.product_key_skey};;
    relationship:  many_to_many
  }

  join:bp_actionplan{
    type: left_outer
    sql_on: ${bp_actionplan.facility_skey} = ${bp_facilities.facility_skey}
      AND ${bp_actionplan.study_skey} = ${bp_categories.study_skey};;
    relationship: one_to_many
  }
  join: bp_security {
    type: inner
    sql_on:
    ${bp_security.member_skey} = ${bp_studydetail.facility_skey}
    AND ${bp_security.demo_user} = ${bp_facilities.bp_demo};;
    relationship: many_to_many
    required_access_grants: [clinicalviewadmin]
  }
  access_filter: {
    field: bp_security.user_id
    user_attribute: email
  }
}

explore: bp_podetail {
  label: "Pedi ClinicalView PO Data Model"
  group_label: "Pedi ClinicalView"
  description: "PO Data"
  persist_with: podetail_change
  #studydetail_change


  fields: [ALL_FIELDS*
    ,-bp_facilities.facility_exclusions*
    ,-bp_categories.category_exclusions*
    ,-bp_podetail.bp_podetail_exclusions*
  ]

  join: bp_categories {
    type: left_outer
    sql_on: ${bp_categories.study_skey} = ${bp_podetail.analysis_skey} ;;
    relationship: one_to_many
  }

  join: bp_facilities {
    type: left_outer
    sql_on: ${bp_facilities.facility_skey} = ${bp_podetail.member_skey};;
    relationship: one_to_many
  }

  join: analysis_desi_key_master{
    type: left_outer
    sql_on: ${analysis_desi_key_master.analysis_skey} = ${bp_podetail.analysis_skey}
          AND ${analysis_desi_key_master.data_designation_skey} = ${bp_podetail.data_designation_skey}
          AND ${analysis_desi_key_master.product_key_skey} = ${bp_podetail.product_key_skey};;
    relationship:  many_to_many
  }

  join: bp_security {
    type: inner
    sql_on:
    ${bp_security.member_skey} = ${bp_podetail.member_skey}
    AND ${bp_security.demo_user} = ${bp_facilities.bp_demo};;
    relationship: many_to_many
    required_access_grants: [clinicalviewadmin]
  }
  access_filter: {
    field: bp_security.user_id
    user_attribute: email
  }
}

explore: bp_projectdetail{
  label: "Pedi Project Details"
  group_label: "Pedi ClinicalView"
  description: "Pedi Project Details"
  extends: [bp_studydetail]
  from: bp_studydetail
  view_name: bp_studydetail
  persist_with: no_cache

  fields: [ALL_FIELDS*
    ,-bp_projectrollup.rollup_exclusions*
  ]

  join: bp_projectrollup {
    type: left_outer
    sql_on: ${bp_projectrollup.project_id} = ${bp_studydetail.project_id}
      ;;
    relationship: many_to_many
    sql_where: ${bp_projectrollup.deleted} = '0' and ${bp_projectrollup.project_status_id} <> 'Archived' ;;
  }
}


explore: bp_studydetailenduser{
  query: categorized_totals {
    dimensions: [bp_categories.study_category, bp_categories.study_name, bp_facilities.facility_name]
    measures: [cache_bpfct_podetail_full.quantity, cache_bpfct_podetail_full.total_cost]
    label: "Total BP Categorized Spend and Quantity"
    description: "Totals by Facility and Study"
    ## pivots: [dimension1, dimension2, … ]
    ## sorts: [field1: asc, field2: desc, … ]
    filters: [bp_categories.study_name: "Advanced Wound Care"]
    ##timezone: timezone
  }
  query: mmis_search {
    dimensions: [bp_facilities.facility_name, cache_bpdim_podetail_full.mmis_item_no, cache_bpdim_podetail_full.facility_manufacturer_name, cache_bpdim_podetail_full.facility_manufacturer_catalog_no, cache_bpdim_podetail_full.facility_item_description, cache_bpdim_podetail_full.facility_vendor_catalog_no, cache_bpdim_podetail_full.facility_vendor_name]
    measures: [cache_bpfct_podetail_full.quantity, cache_bpfct_podetail_full.total_cost]
    label: "Search Your Uncategorized Data by MMIS"
    description: "Search through all data not in BP Category"
    ## pivots: [dimension1, dimension2, … ]
    ## sorts: [field1: asc, field2: desc, … ]
    filters: [cache_bpdim_podetail_full.mmis_item_no: "0", cache_bpdim_podetail_full.facility_item_description: "", cache_bpdim_podetail_full.facility_manufacturer_name: "", cache_bpdim_podetail_full.facility_vendor_catalog_no: "", cache_bpdim_podetail_full.facility_vendor_name: "", bp_categories.study_name: "NULL"]
    ##timezone: timezone
  }

#  view_name: bp_studydetail
  view_name: cache_bpdim_podetail_full
  label: "Pedi Annual All Spend Data"
  group_label: "Pedi End User Explores"
  description: "Line item data showing both categorized and uncategorized spend over the most recent year"
  persist_with: podetail_change

  fields: [
    bp_facilities.enduser*
    ,bp_categories.enduser*
    ,bp_security.detail*
    ,-bp_studydetail.enduser*
    ,cache_bpdim_podetail_full.enduser*
    ,cache_bpfct_podetail_full.enduser*
    ,analysis_desi_key_master.enduser*
  ]

  join: bp_studydetail {
    type: left_outer
    sql_on: ${cache_bpdim_podetail_full.analysis_skey} = ${bp_studydetail.study_skey}
      AND ${cache_bpdim_podetail_full.member_skey} = ${bp_studydetail.facility_skey};;
    ##     AND ${cache_bpdim_podetail_full.end_date_skey} = ${bp_studydetail.raw_study_end_date};;
    relationship: many_to_many
  }

  join: bp_categories {
    type: left_outer
    sql_on: ${bp_categories.study_skey} = ${cache_bpdim_podetail_full.analysis_skey} ;;
    relationship: one_to_many
  }
  join: bp_facilities {
    type: left_outer
    sql_on: ${bp_facilities.facility_skey} = ${cache_bpdim_podetail_full.member_skey};;
    relationship: one_to_many
  }

#  join: cache_bpdim_podetail_full {
#    type: left_outer
#    sql_on: ${cache_bpdim_podetail_full.analysis_skey} = ${bp_studydetail.study_skey}
#          AND ${cache_bpdim_podetail_full.member_skey} = ${bp_studydetail.facility_skey};;
#     ##     AND ${cache_bpdim_podetail_full.end_date_skey} = ${bp_studydetail.raw_study_end_date};;
#    relationship: many_to_many
#  }

  join: cache_bpfct_podetail_full {
    type: left_outer
    sql_on: ${cache_bpfct_podetail_full.po_skey} = ${cache_bpdim_podetail_full.po_skey} ;;
    relationship: many_to_many
  }

  join: analysis_desi_key_master{
    type: left_outer
    sql_on: ${analysis_desi_key_master.analysis_skey} = ${cache_bpdim_podetail_full.analysis_skey}
          AND ${analysis_desi_key_master.data_designation_skey} = ${cache_bpdim_podetail_full.data_designation_skey}
          AND ${analysis_desi_key_master.product_key_skey} = ${cache_bpdim_podetail_full.product_key_skey};;
    relationship:  many_to_many
  }
  join: bp_security {
    type: inner
    sql_on:
    ${bp_security.member_skey} = ${cache_bpdim_podetail_full.member_skey}
    AND ${bp_security.demo_user} = ${bp_facilities.bp_demo};;
    relationship: many_to_many
    ##  required_access_grants: [clinicalviewadmin]
  }
  access_filter: {
    field: bp_security.user_id
    user_attribute: email
  }
}

explore: bp_studydetailyankeeenduser
{
  query: categorized_totals {
    dimensions: [bp_categories.study_category, bp_categories.study_name, bp_facilities.facility_name]
    measures: [cache_bpfct_podetail_full.quantity, cache_bpfct_podetail_full.total_cost]
    label: "Total BP Categorized Spend and Quantity"
    description: "Totals by Facility and Study"
    ## pivots: [dimension1, dimension2, … ]
    ## sorts: [field1: asc, field2: desc, … ]
    filters: [bp_categories.study_name: "Advanced Wound Care"]
    ##timezone: timezone
  }
  query: mmis_search {
    dimensions: [bp_facilities.facility_name, cache_bpdim_podetail_full.mmis_item_no, cache_bpdim_podetail_full.facility_manufacturer_name, cache_bpdim_podetail_full.facility_manufacturer_catalog_no, cache_bpdim_podetail_full.facility_item_description, cache_bpdim_podetail_full.facility_vendor_catalog_no, cache_bpdim_podetail_full.facility_vendor_name]
    measures: [cache_bpfct_podetail_full.quantity, cache_bpfct_podetail_full.total_cost]
    label: "Search Your Uncategorized Data by MMIS"
    description: "Search through all data not in BP Category"
    ## pivots: [dimension1, dimension2, … ]
    ## sorts: [field1: asc, field2: desc, … ]
    filters: [cache_bpdim_podetail_full.mmis_item_no: "0", cache_bpdim_podetail_full.facility_item_description: "", cache_bpdim_podetail_full.facility_manufacturer_name: "", cache_bpdim_podetail_full.facility_vendor_catalog_no: "", cache_bpdim_podetail_full.facility_vendor_name: "", bp_categories.study_name: "NULL"]
    ##timezone: timezone
  }

  query: spend_analysis{
    dimensions: [bp_facilities.facility_name,
      analysis_desi_key_master.data_designation_name,
      analysis_desi_key_master.product_key_name,
      cache_bpdim_podetail_full.manufacturer_master,
      cache_bpdim_podetail_full.manufacturer_catalog_no,
      cache_bpdim_podetail_full.product_description,
      cache_bpdim_podetail_full.uom,
      cache_bpdim_podetail_full.conversion_factor,
      cache_bpfct_podetail_full.spend_to_ea,
      cache_bpfct_podetail_full.purchase_date
    ]
    measures: [cache_bpfct_podetail_full.quantity,
      cache_bpfct_podetail_full.total_cost]
    label: "Standard Yankee Spend Analysis"
    description: "Check on data using the Spend Analysis"
    ## pivots: [dimension1, dimension2, … ]
    ## sorts: [field1: asc, field2: desc, … ]
    filters: [bp_categories.study_name: "Advanced Wound Care",
      cache_bpfct_podetail_full.purchase_date: "", bp_facilities.facility_name: ""]
    ##timezone: timezone
  }

#  view_name: bp_studydetail
  view_name: cache_bpdim_podetail_full
  label: "Pedi Annual All Spend Data - YA"
  group_label: "Pedi End User Explores"
  description: "Line item data showing both categorized and uncategorized spend over the most recent year"
  persist_with: podetail_change

  fields: [
    bp_facilities.enduser*
    ,bp_categories.enduser*
    ,bp_security.detail*
    ,-bp_studydetail.enduser*
    ,cache_bpdim_podetail_full.enduser*
    ,cache_bpfct_podetail_full.enduser*
    ,analysis_desi_key_master.enduser*
  ]

  join: bp_studydetail {
    type: left_outer
    sql_on: ${cache_bpdim_podetail_full.analysis_skey} = ${bp_studydetail.study_skey}
      AND ${cache_bpdim_podetail_full.member_skey} = ${bp_studydetail.facility_skey};;
    ##     AND ${cache_bpdim_podetail_full.end_date_skey} = ${bp_studydetail.raw_study_end_date};;
    relationship: many_to_many
  }

  join: bp_categories {
    type: left_outer
    sql_on: ${bp_categories.study_skey} = ${cache_bpdim_podetail_full.analysis_skey} ;;
    relationship: one_to_many
  }
  join: bp_facilities {
    type: left_outer
    sql_on: ${bp_facilities.facility_skey} = ${cache_bpdim_podetail_full.member_skey};;
    relationship: one_to_many
  }



  join: cache_bpfct_podetail_full {
    type: left_outer
    sql_on: ${cache_bpfct_podetail_full.po_skey} = ${cache_bpdim_podetail_full.po_skey} ;;
    relationship: many_to_many
  }

  join: analysis_desi_key_master{
    type: left_outer
    sql_on: ${analysis_desi_key_master.analysis_skey} = ${cache_bpdim_podetail_full.analysis_skey}
          AND ${analysis_desi_key_master.data_designation_skey} = ${cache_bpdim_podetail_full.data_designation_skey}
          AND ${analysis_desi_key_master.product_key_skey} = ${cache_bpdim_podetail_full.product_key_skey};;
    relationship:  many_to_many
  }
  join: bp_security {
    type: inner
    sql_on:
    ${bp_security.member_skey} = ${cache_bpdim_podetail_full.member_skey}
    AND ${bp_security.demo_user} = ${bp_facilities.bp_demo};;
    relationship: many_to_many
    ##  required_access_grants: [clinicalviewadmin]
  }
  access_filter: {
    field: bp_security.user_id
    user_attribute: email
  }
}
