view: cache_bpdim_podetail_full {
  view_label: "BP Data Details"
  sql_table_name: dbo.CacheBPdimPODetailFull ;;

  dimension: po_skey {
    type: number
    sql: ${TABLE}.PO_Skey ;;
    primary_key: yes
    hidden: yes
  }

  dimension: analysis_skey {
    type: number
    sql: ${TABLE}.Analysis_Skey ;;
  }

  dimension: ansi_uom {
    type: string
    sql: ${TABLE}.Ansi_UOM ;;
    label: "BP UOM"
  }

  dimension: conversion_factor {
    type: number
    sql: ${TABLE}.Conversion_Factor ;;
    label: "BP Conversion Factor"
  }

  dimension: data_cleansing_code {
    type: string
    sql: ${TABLE}.Data_Cleansing_Code ;;
  }

  dimension: data_designation_skey {
    type: number
    sql: ${TABLE}.Data_Designation_Skey ;;
  }

  dimension: end_date_skey {
    type: number
    sql: ${TABLE}.End_Date_Skey ;;
  }

  dimension: facility_item_description {
    type: string
    sql: ${TABLE}.Facility_Item_Description ;;
    view_label: "Unclassified Fields"
  }

  dimension: facility_manufacturer_catalog_no {
    type: string
    sql: ${TABLE}.Facility_Manufacturer_Catalog_No ;;
    view_label: "Unclassified Fields"
  }

  dimension: facility_manufacturer_name {
    type: string
    sql: ${TABLE}.Facility_Manufacturer_Name ;;
    view_label: "Unclassified Fields"
  }

  dimension: facility_vendor_catalog_no {
    type: string
    sql: ${TABLE}.Facility_Vendor_Catalog_No ;;
    view_label: "Unclassified Fields"
  }

  dimension: facility_vendor_name {
    type: string
    sql: ${TABLE}.Facility_Vendor_Name ;;
    view_label: "Unclassified Fields"
  }

  dimension: manufacturer_catalog_no {
    type: string
    sql: ${TABLE}.Manufacturer_Catalog_No ;;
    label: "BP Manufacturer Catalog Number"
  }

  dimension: manufacturer_master {
    type: string
    sql: ${TABLE}.Manufacturer_Master ;;
    label: "BP Manufacturer Master"
  }

  dimension: member_skey {
    type: number
    sql: ${TABLE}.Member_Skey ;;
  }

  dimension: mmis_item_no {
    type: string
    sql: ${TABLE}.MMIS_Item_No ;;
    label: "MMIS Item Number"
    view_label: "Unclassified Fields"
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.Order_Type ;;
    view_label: "Unclassified Fields"
  }

  dimension: product_description {
    type: string
    sql: ${TABLE}.Product_Description ;;
    label: "BP Product Description"
  }

  dimension: product_key_skey {
    type: number
    sql: ${TABLE}.Product_Key_Skey ;;
  }

  dimension: sub_facility {
    type: string
    sql: ${TABLE}.Sub_Facility ;;
  }

  dimension: uom {
    type: string
    sql: ${TABLE}.UOM ;;
    label: "UOM"
    view_label: "Unclassified Fields"
  }

  dimension: vendor_catalog_no {
    type: string
    sql: ${TABLE}.Vendor_Catalog_No ;;
  }

  dimension: vendor_master {
    type: string
    sql: ${TABLE}.Vendor_Master ;;
  }

  measure: count {
    type: count
    drill_fields: [facility_manufacturer_name, facility_vendor_name]
  }

  set: enduser{
    fields: [
      ansi_uom,
      conversion_factor,
      facility_item_description,
      facility_manufacturer_catalog_no,
      facility_manufacturer_name,
      facility_vendor_catalog_no,
      facility_vendor_name,
      manufacturer_catalog_no,
      manufacturer_master,
      mmis_item_no,
      product_description,
      uom,
      order_type
    ]
  }
}
