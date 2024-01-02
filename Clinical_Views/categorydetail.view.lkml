view: bp_studydetail{
  view_label: "BP Category Detail"
  sql_table_name:dbo.CacheBPfctFacilityStudyDetail
    ;;

  dimension: detail_id {
    type: number
    sql: ${TABLE}.Detail_Id ;;
    primary_key: yes
  }

  dimension: facility_skey {
    type: number
    sql: ${TABLE}.FacilitySkey ;;
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
      date,
      month
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.StudyEndDate;;
  }

  dimension_group: BP_category_start{
    label: "BP Category Start"
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

  dimension_group: BP_category_month{
    label: "BP Category Month"
    type: time
    timeframes: [
      month
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.StudyEndDate;;
  }

  dimension: target_savings {
    type: number
    sql: ${TABLE}.TargetSavings ;;
  }

  dimension: project_achieved_savings {
    type: number
    sql: ${TABLE}.ProjectAchievedSavings ;;
  }

  dimension: positive_target_savings {
    type: number
    sql: ${TABLE}.PositiveTargetSavings ;;
  }

  dimension: cmi {
    label: "CMI"
    type: number
    sql: ${TABLE}.CMI ;;
  }

  dimension: prior_month_spend_metric {
    type: number
    sql: ${TABLE}.PriorMonthSpendMetric ;;
  }

  dimension: spend_metric {
    type: number
    sql: ${TABLE}.SpendMetric ;;
  }

  dimension: quantity_metric {
    type: number
    sql: ${TABLE}.QuantityMetric ;;
  }

  dimension: stat_value {
    type: number
    sql: ${TABLE}.StatValue ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.ProjectID ;;
  }

  dimension: spend_top_quartile{
    type: string
    sql: ${TABLE}.SpendTopQuartile ;;
  }

  dimension: quantity_top_quartile{
    type: string
    sql: ${TABLE}.QuantityTopQuartile ;;
  }

  dimension: total_spend{
    type: string
    sql: ${TABLE}.TotalSpend ;;
  }

  dimension: kpi_flag {
    type: string
    sql:  ${TABLE}.KPIFlag ;;
  }

  dimension: performing_rank {
    type: string
    sql: CASE WHEN ${TABLE}.KPIFlag = '1'
                THEN 'Top Performing'
                WHEN ${TABLE}.KPIFlag = '-1'
                THEN 'Bottom Performing'
                ELSE 'Average Performing'
                END;;
  }

  dimension: performing_rank_with_drill{
    type: string
    sql: CASE WHEN ${TABLE}.KPIFlag = '1'
                THEN 'Top Performing'
                WHEN ${TABLE}.KPIFlag = '-1'
                THEN 'Bottom Performing'
                ELSE 'Average Performing'
                END;;
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Performance%20Rank={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
  }

  measure: count {
    type: count
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name, performing_rank]
  }

  measure: total_positive_target_savings{
    type: sum
    sql: ${positive_target_savings} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_positive_target_savings]
  }

  measure: total_positive_target_savings_with_home_drills{
    view_label: "Home Page Fields"
    type: sum
    sql: ${positive_target_savings} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_positive_target_savings]
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: total_positive_target_savings_all_drills{
    type: sum
    sql: ${positive_target_savings} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_positive_target_savings]
    link: {
      label: "Back to Home Dashboard"
      url: "/dashboards/152?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: total_achieved_savings{
    type: sum
    sql: ${project_achieved_savings};;
    value_format_name: usd_0
    drill_fields: [total_achieved_savings,bp_facilities.facility_name, bp_projectrollup.project_name, bp_categories.study_name,BP_category_end_date]
    # link: {
    #    label: "Back to Home Dashboard"
    #    url: "/dashboards/FTvZmlSkAIhagJZyExhOhE?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    #  }
    #  link: {
    #    label: "View Trend Summary Dashboard"
    #    url: "/dashboards/hFZnDlnqb39QDudvrjuI3t?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    #  }
    #  link: {
    #    label: "View Trend Detail Dashboard"
    #    url: "/dashboards/Bp47IJCULCJA60bAZU4OmZ?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    #  }
    #  link: {
    #    label: "View BP Category Data"
    #    url:  "/dashboards/F4e5BTmIB2vL0dTu6TGB9d?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    # }
    #  link: {
    #    label: "View Target Savings Report"
    #    url: "/dashboards/83?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    #  }
  }
  measure: total_achieved_savings_home_dashboard{
    view_label: "Home Page Fields"
    type: sum
    sql: ${project_achieved_savings};;
    value_format_name: usd_0
    #   drill_fields: [total_achieved_savings,bp_facilities.facility_name, bp_projectrollup.project_name, bp_categories.study_name,BP_category_end_date]
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: total_achieved_savings_home_chart{
    view_label: "Home Page Fields"
    type: sum
    sql: ${project_achieved_savings};;
    value_format_name: usd_0
    # drill_fields: [total_achieved_savings,bp_facilities.facility_name, bp_projectrollup.project_name, bp_categories.study_name,BP_category_end_date]
    link: {
      label: "View Achieved Savings Dashboard"
      url: "/dashboards/156?Project%20Name={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }


  measure: running_total_achieved_savings{
    type: running_total
    sql: ${total_achieved_savings};;
    value_format_name: usd_0
#       drill_fields: [bp_facilities.facility_name]
  }

  measure: positive_total_achieved_savings{
    type: sum
    sql: CASE WHEN ${project_achieved_savings} < 0 THEN 0 ELSE ${project_achieved_savings} END;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name_2,positive_total_achieved_savings]
  }

  measure: total_spend_metric{
    type: sum
    sql: ${spend_metric} ;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_spend_metric]
  }

  measure: total_quantity_metric{
    type: sum
    sql: ${quantity_metric} ;;
    value_format_name: decimal_1
    drill_fields: [bp_facilities.facility_name]
  }

  measure: total_prior_month_spend_metric{
    type: sum
    sql: ${prior_month_spend_metric} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name]
  }

  measure: total_spend_top_quartile{
    type: sum_distinct
    sql: ${spend_top_quartile} ;;
    value_format_name: usd
    drill_fields: [bp_facilities.facility_name]
  }

  measure: total_quantity_top_quartile{
    type: sum
    sql: ${quantity_top_quartile} ;;
    value_format_name: decimal_1
    drill_fields: [bp_facilities.facility_name]
  }

  measure: total_study_spend{
    type: sum
    sql: ${total_spend} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_study_spend]
  }

  measure: total_study_spend_home_drills{
    view_label: "Home Page Fields"
    type: sum
    sql: ${total_spend} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_study_spend]
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: total_study_spend_all_drills{
    type: sum
    sql: ${total_spend} ;;
    value_format_name: usd_0
    drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_study_spend]
    link: {
      label: "Back to Home Dashboard"
      url: "/dashboards/152?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: total_study_spend_kpi{
    view_label: "KPI Fields"
    type: sum
    sql: ${total_spend} ;;
    value_format_name: usd_0
    #  drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_study_spend]
    link: {
      label: "Back to Home Dashboard"
      url: "/dashboards/152?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&BP%20Category={{ _filters['bp_categories.study_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&BP%20Category={{ _filters['bp_categories.study_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&BP%20Category={{ _filters['bp_categories.study_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  measure: total_positive_target_savings_kpi{
    view_label: "KPI Fields"
    type: sum
    sql: ${positive_target_savings} ;;
    value_format_name: usd_0
    #  drill_fields: [bp_facilities.facility_name,bp_categories.study_name,total_study_spend]
    link: {
      label: "Back to Home Dashboard"
      url: "/dashboards/152?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&BP%20Category={{ _filters['bp_categories.study_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&BP%20Category={{ _filters['bp_categories.study_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&BP%20Category={{ _filters['bp_categories.study_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  set: facility{
    fields: [
      bp_facilities.facility_name,
      bp_facilities.facility_custom_region
    ]
  }

  set: detail {
    fields: [
      facility_skey,
      study_skey,
      detail_id,
      BP_category_end_date,
      target_savings,
      project_achieved_savings,
      positive_target_savings,
      cmi,
      prior_month_spend_metric,
      spend_metric,
      stat_value,
      project_id
    ]
  }

  set: enduser{
    fields: [
      BP_category_end_date
    ]
  }

  set: studydetail_exclusions {
    fields: [
      facility_skey
      ,study_skey
      ,detail_id
      ,project_id
      ,spend_top_quartile
      ,quantity_top_quartile

    ]
  }
}
