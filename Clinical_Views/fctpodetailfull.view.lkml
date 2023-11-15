view: cache_bpfct_podetail_full {
  view_label: "BP Data Details"
  sql_table_name: dbo.CacheBPfctPODetailFull ;;

  dimension: fct_PO_Skey {
    type: number
    sql: ${TABLE}.fct_PO_Skey ;;
    primary_key: yes
    hidden: yes
  }

  dimension: po_skey {
    type: number
    sql: ${TABLE}.PO_Skey ;;
    hidden: yes
  }

  dimension: cost {
    type: string
    sql: ${TABLE}.Cost ;;
  }

  dimension: cost_center_code {
    type: string
    sql: ${TABLE}.Cost_Center_Code ;;
    view_label: "Unclassified Fields"
  }

  dimension: cost_center_name {
    type: string
    sql: ${TABLE}.Cost_Center_Name ;;
    view_label: "Unclassified Fields"
  }

  dimension: department_code {
    type: string
    sql: ${TABLE}.Department_Code ;;
    view_label: "Unclassified Fields"
  }

  dimension: department_name {
    type: string
    sql: ${TABLE}.Department_Name ;;
    view_label: "Unclassified Fields"
  }

  dimension: po_line {
    type: string
    sql: ${TABLE}.Po_Line ;;
    label: "PO Line"
    view_label: "Unclassified Fields"
  }

  dimension: po_number {
    type: string
    sql: ${TABLE}.Po_Number ;;
    label: "PO Number"
    view_label: "Unclassified Fields"
  }

  dimension_group: purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Purchase_Date ;;
    view_label: "Unclassified Fields"
  }

  measure: quantity {
    type: sum
    sql: ${TABLE}.Quantity ;;
  }

  measure: quantity_to_ea {
    type: sum
    sql: ${TABLE}.Quantity_To_Ea ;;
  }

  dimension: spend_to_ea {
    type: string
    sql: ${TABLE}.Spend_To_Ea ;;
    label: "Calculated Spend to Each"
  }


  measure: count {
    type: count
    drill_fields: [cost_center_name, department_name]
  }

  measure: total_cost {
    type: sum
    sql: ${TABLE}.Total_Cost ;;
    value_format_name: usd
  }

  set: enduser{
    fields: [
      cost_center_code,
      cost_center_name,
      department_code,
      department_name,
      po_line,
      po_number,
      purchase_date,
      purchase_week,
      purchase_month,
      purchase_quarter,
      purchase_year,
      quantity_to_ea,
      quantity,
      spend_to_ea,
      total_cost
    ]
  }
}
