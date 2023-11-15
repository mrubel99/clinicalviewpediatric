view: bp_categoryrollup{
  view_label: "BP Category Rollup"
  sql_table_name:dbo.viewBPfctcategoryrollup
    ;;

  dimension: rollup_id{
    type: number
    sql: ${TABLE}.RollupID ;;
    primary_key: yes
  }

  dimension: study_skey {
    type: number
    sql: ${TABLE}.StudySkey ;;
  }

  dimension: raw_study_end_date {
    type: date
    sql: ${TABLE}.StudyEndDate ;;
  }

  dimension_group: BP_category_end{
    label: "BP Category End"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.StudyEndDate;;
  }

  dimension: spend_top_quartile{
    type: number
    sql: ${TABLE}.SpendTopQuartile ;;
  }

  dimension: quantity_top_quartile{
    type: string
    sql: ${TABLE}.QuantityTopQuartile ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_spend_top_quartile{
    type: sum
    sql: ${spend_top_quartile} ;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name]
  }

  measure: total_quantity_top_quartile{
    type: sum
    sql: ${quantity_top_quartile} ;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name]
  }

  set: facility{
    fields: [
      bp_facilities.facility_name,
      bp_facilities.facility_custom_region
    ]
  }

  set: detail {
    fields: [

      study_skey,
      BP_category_end_date,
    ]
  }

  set: bp_categoryrollup_exclusions {
    fields: [
      rollup_id
      ,study_skey
    ]
  }
}
