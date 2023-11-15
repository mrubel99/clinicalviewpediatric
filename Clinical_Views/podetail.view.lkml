view: bp_podetail{
  view_label: "BP PO Detail"
  sql_table_name:dbo.CacheBPfctPODetail;;

  dimension: podetail_skey {
    type: number
    sql: ${TABLE}.PODetail_Skey ;;
    primary_key: yes
  }

  parameter: usage_type_selector{
    type: unquoted
#       default_value: "ProductType"
    allowed_value: {
      label: "Cost Center"
      value: "CostCenter"
    }
    allowed_value: {
      label: "Department Name"
      value: "DeptName"
    }
    allowed_value: {
      label: "Manufacturer"
      value: "Manufacturer"
    }
    allowed_value: {
      label: "Product Detail"
      value: "ProductDetail"
    }
    allowed_value: {
      label: "Product Type"
      value: "ProductType"
    }
    allowed_value: {
      label: "Vendor"
      value: "Vendor"
    }
  }

  dimension:  usage_type_dynamic_dimension{
    type: string
#       label: "{% parameter usage_type_selector %}"
    label: "Usage Type"
    sql: {% if usage_type_selector._parameter_value == "CostCenter"  %}
      ${cost_center_name}
      {% elsif usage_type_selector._parameter_value == "DeptName"  %}
      ${department_name}
      {% elsif usage_type_selector._parameter_value == "Manufacturer"  %}
      ${manufacturer_master}
      {% elsif usage_type_selector._parameter_value == "ProductDetail"  %}
      ${analysis_desi_key_master.product_key_name}
      {% elsif usage_type_selector._parameter_value == "Vendor"  %}
      ${vendor_master}
      {% else %}
      ${analysis_desi_key_master.data_designation_name}
      {% endif %}
      ;;
  }

  dimension: analysis_skey {
    type: number
    sql: ${TABLE}.AnalysisSkey ;;
  }

  dimension: member_skey {
    type: number
    sql: ${TABLE}.MemberSkey ;;
  }

  dimension: product_key_skey {
    type: number
    sql: ${TABLE}.ProductKeySkey ;;
  }

  dimension: data_designation_skey {
    type: number
    sql: ${TABLE}.DataDesignationSkey ;;
  }

  dimension: end_date_skey {
    type: number
    sql: ${TABLE}.EndDateSkey ;;
  }

  dimension: raw_po_end_date {
    type: date
    sql: ${TABLE}.EndDate ;;
  }

  dimension_group: BP_po_end{
    label: "BP PO End"
    type: time
    timeframes: [
      date,
      month
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EndDate;;
  }

  dimension: ansi_uom {
    label: "ANSI UOM"
    type: string
    sql: ${TABLE}.AnsiUOM ;;
  }

  dimension: conversion_factor {
    type: number
    sql: ${TABLE}.ConversionFactor ;;
  }

  dimension: cost_center_code {
    type: string
    sql: ${TABLE}.CostCenterCode ;;
  }

  dimension: cost_center_name {
    type: string
    sql: ${TABLE}.CostCenterName ;;
  }

  dimension: data_cleansing_code {
    type: string
    sql: ${TABLE}.DataCleansingCode ;;
  }

  dimension: department_code {
    type: string
    sql: ${TABLE}.DepartmentCode ;;
  }

  dimension: department_name {
    type: string
    sql: ${TABLE}.DepartmentName ;;
  }

  dimension: facility_item_description {
    type: string
    sql: ${TABLE}.FacilityItemDescription ;;
  }

  dimension: facility_manufacturer_catalog_no {
    type: string
    sql: ${TABLE}.FacilityManufacturerCatalogNo ;;
  }

  dimension: facility_manufacturer_name {
    type: string
    sql: ${TABLE}.FacilityManufacturerName ;;
  }

  dimension: facility_vendor_catalog_no {
    type: string
    sql: ${TABLE}.FacilityVendorCatalogNo ;;
  }

  dimension: facility_vendor_name {
    type: string
    sql: ${TABLE}.FacilityVendorName ;;
  }

  dimension: manufacturer_catalog_no {
    type: string
    sql: ${TABLE}.ManufacturerCatalogNo ;;
  }

  dimension: manufacturer_master {
    type: string
    sql: ${TABLE}.ManufacturerMaster ;;
  }

  dimension: mmisitem_no {
    label: "MMIS Item No"
    type: string
    sql: ${TABLE}.MMISItemNo ;;
  }

  dimension: po_line {
    type: string
    sql: ${TABLE}.PoLine ;;
  }

  dimension: po_number {
    type: string
    sql: ${TABLE}.PoNumber ;;
  }

  dimension: product_description {
    type: string
    sql: ${TABLE}.ProductDescription ;;
  }

  dimension: purchase_date {
    type: date
    sql: ${TABLE}.PurchaseDate ;;
  }

  dimension: vendor_catalog_no {
    type: string
    sql: ${TABLE}.VendorCatalogNo ;;
  }

  dimension: vendor_master {
    type: string
    sql: ${TABLE}.VendorMaster ;;
  }

  dimension: cost {
    type: string
    sql: ${TABLE}.Cost ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  dimension: quantity_to_ea {
    type: number
    sql: ${TABLE}.QuantityToEa ;;
  }

  dimension: spend_to_ea {
    type: string
    sql: ${TABLE}.SpendToEa ;;
  }

  dimension: total_cost_base {
    label: "Total PO Spend"
    type: string
    sql: ${TABLE}.TotalCostBase ;;
  }

  dimension: sub_facility {
    type: string
    sql: CASE
      WHEN bp_facilities.IsDemo = '1' THEN bp_facilities.FacilityBenchmarkCode
      ELSE ${TABLE}.SubFacility
      END ;;
  }

  dimension: uom {
    label: "UOM"
    type: string
    sql: ${TABLE}.UOM ;;
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.OrderType ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: Total_PO_Spend{
    type: sum
    sql: ${TABLE}.TotalCostBase;;
    value_format_name: usd
  }

  measure: Total_PO_Spend_with_drill{
    type: sum
    sql: ${TABLE}.TotalCostBase;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,Total_PO_Spend]
    link: {
      label: "Back to Home Dashboard"
      url: "/dashboards/FTvZmlSkAIhagJZyExhOhE?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/hFZnDlnqb39QDudvrjuI3t?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/Bp47IJCULCJA60bAZU4OmZ?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/F4e5BTmIB2vL0dTu6TGB9d?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/OrYnjIUR71GCOhdItyXc6c?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: Total_Product_Type_Spend{
    type: sum
    sql: ${TABLE}.TotalCostBase;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name_2,analysis_desi_key_master.data_designation_name, analysis_desi_key_master.product_key_name,Total_Product_Type_Spend]
  }

  measure: Total_Product_Detail_Spend{
    type: sum
    sql: ${TABLE}.TotalCostBase;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name_2,analysis_desi_key_master.data_designation_name, analysis_desi_key_master.product_key_name, Total_Product_Detail_Spend]
  }

  measure: total_quantity{
    type: sum
    sql: ${TABLE}.QuantityToEa;;
    value_format_name: decimal_0
  }

  set: detail {
    fields: [
      podetail_skey,
      analysis_skey,
      member_skey,
      product_key_skey,
      data_designation_skey,
      end_date_skey,
      raw_po_end_date,
      ansi_uom,
      conversion_factor,
      cost_center_code,
      cost_center_name,
      data_cleansing_code,
      department_code,
      department_name,
      facility_item_description,
      facility_manufacturer_catalog_no,
      facility_manufacturer_name,
      facility_vendor_catalog_no,
      facility_vendor_name,
      manufacturer_catalog_no,
      manufacturer_master,
      mmisitem_no,
      po_line,
      po_number,
      product_description,
      purchase_date,
      vendor_catalog_no,
      vendor_master,
      cost,
      quantity,
      quantity_to_ea,
      spend_to_ea,
      total_cost_base,
      sub_facility,
      uom,
      order_type
    ]
  }
  set: bp_podetail_exclusions{
    fields:[
      podetail_skey,
      analysis_skey,
      member_skey,
      product_key_skey,
      data_designation_skey,
      end_date_skey,
    ]
  }
}
