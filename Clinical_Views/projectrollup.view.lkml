view: bp_projectrollup {
  view_label: "BP Project Rollup"
  sql_table_name: viewVinylBPProjectRollup;;

  dimension: project_rollup_id {
    type: number
    sql: ${TABLE}.ProjectRollupID ;;
    primary_key: yes
  }

  dimension: facility_project_id{
    type: string
    sql: ${TABLE}.FacilityProjectID ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.ProjectID ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.ProjectName ;;
  }

  dimension: project_name_home_chart {
    view_label: "Home Page Fields"
    type: string
    sql: ${TABLE}.ProjectName ;;
    link: {
      label: "View Achieved Savings Dashboard"
      url: "/dashboards/156?Project%20Name={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
    }
  }

  dimension: facility_id {
    type: number
    sql: ${TABLE}.FacilityID ;;
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.CategoryID ;;
  }

  dimension: project_expected_savings {
    type: number
    sql: ${TABLE}.ProjectExpectedSavings ;;
  }

  dimension: facility_expected_savings {
    type: number
    sql: ${TABLE}.FacilityExpectedSavings ;;
  }

  dimension: raw_project_baseline_date {
    type: date
    sql: ${TABLE}.ProjectBaselineDate ;;
    hidden: yes
  }

  dimension_group: project_baseline{
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
    sql: ${TABLE}.ProjectBaselineDate;;
  }

  dimension: raw_facility_baseline_date {
    type: date
    sql: ${TABLE}.FacilityBaselineDate ;;
    hidden: yes
  }

  dimension_group: facility_baseline{
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
    sql: ${TABLE}.FacilityBaselineDate;;
  }

  dimension: project_savings_period {
    type: number
    sql: ${TABLE}.ProjectSavingsPeriod ;;
  }

  dimension: facility_savings_period {
    type: number
    sql: ${TABLE}.FacilitySavingsPeriod ;;
  }

  dimension: project_track_savings {
    type: string
    sql: ${TABLE}.ProjectTrackSavings ;;
  }

  dimension: facility_track_savings {
    type: string
    sql: ${TABLE}.FacilityTrackSavings ;;
  }

  dimension: raw_project_start_date {
    type: date
    sql: ${TABLE}.ProjectStartDate ;;
  }

  dimension_group: project_start{
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
    sql: ${TABLE}.ProjectStartDate;;
  }

  dimension: raw_facility_start_date {
    type: date
    sql: ${TABLE}.FacilityStartDate ;;
  }

  dimension_group: facility_start{
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
    sql: ${TABLE}.FacilityStartDate;;
  }

  dimension: raw_project_end_date {
    type: date
    sql: ${TABLE}.ProjectEndDate ;;
  }

  dimension_group: project_end{
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
    sql: ${TABLE}.ProjectEndDate;;
  }

  dimension: raw_facility_end_date {
    type: date
    sql: ${TABLE}.FacilityEndDate ;;
  }

  dimension_group: facility_end{
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
    sql: ${TABLE}.FacilityEndDate;;
  }

  dimension: project_owner {
    type: string
    sql: ${TABLE}.ProjectOwner ;;
  }

  dimension: facility_project_owner {
    type: string
    sql: ${TABLE}.FacilityProjectOwner ;;
  }

  dimension: project_status_id {
    label: "Project Status"
    type: string
    link: {
      label: "View Achieved Savings Dashboard"
      url: "/dashboards/156?Project%20Status={{ filterable_value | url_encode }}"
#         "/dashboards/19?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
    sql: ${TABLE}.ProjectStatusID ;;
  }

  dimension: facility_project_status_id {
    label: "Facility Project Status"
    type: string
    sql: ${TABLE}.FacilityProjectStatusID ;;
  }

  parameter: savings_type_selector{
    type: unquoted
    allowed_value: {
      label: "Facility Name"
      value: "FacilityName"
    }
    allowed_value: {
      label: "BP Category"
      value: "BPCategory"
    }
    allowed_value: {
      label: "Project Name"
      value: "ProjectName"
    }
  }

  dimension:  savings_type_dynamic_dimension{
    type: string
    label: "Savings Type"
    sql: {% if savings_type_selector._parameter_value == "FacilityName"  %}
      ${bp_facilities.facility_name}
      {% elsif savings_type_selector._parameter_value == "BPCategory"  %}
      ${bp_categories.study_name}
      {% elsif savings_type_selector._parameter_value == "ProjectName"  %}
      ${project_name}
      {% else %}
      ${bp_categories.study_name}
      {% endif %}
      ;;
  }

  dimension: deleted {
    type: yesno
    label: "Deleted"
    sql: ${TABLE}.Deleted ;;
  }

  measure: total_expected_savings{
    type: sum
    sql: ${project_expected_savings};;
    value_format_name: usd_0
    link: {
      label: "Back to Home Dashboard"
      url: "/dashboards/152?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      project_id,
      facility_id,
      category_id,
      project_expected_savings,
      facility_expected_savings,
      project_baseline_date,
      facility_baseline_date,
      project_savings_period,
      facility_savings_period,
      project_track_savings,
      facility_track_savings,
      project_start_date,
      facility_start_date,
      project_end_date,
      facility_end_date,
      project_owner,
      facility_project_owner,
      project_status_id,
      facility_project_status_id
    ]
  }

  set: rollup_exclusions{
    fields: [
      category_id
      ,facility_id
      ,project_rollup_id
      ,raw_facility_baseline_date
      ,raw_facility_end_date
      ,raw_facility_start_date
      ,raw_project_baseline_date
      ,raw_project_end_date
      ,raw_project_start_date
    ]
  }
}
