view: bp_categories {
  view_label: "BP Categories"
  sql_table_name: dbo.CacheBPdimStudy
    ;;

  dimension: study_skey {
    type: number
    sql: ${TABLE}.StudySkey ;;
    primary_key: yes
  }

  #  dimension: study_name {
  #    type: string
  #    sql: ${TABLE}.StudyName ;;
#      suggest_explore: bp_category_suggestions
#      suggest_dimension: bp_category_suggestions.study_name
#       html: <a href="/dashboards/5?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}">{{rendered_value}}</a>;;
  ##  link: {
  ##    label: "View Action Plan"
  ##    url: "/dashboards/36?BP%20Category={{ filterable_value | url_encode }}"
#         "/dashboards/19?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
  ##  }
  #    link: {
  #      label: "View BP Category Data"
  #      url: "/dashboards/36?BP%20Category={{ filterable_value | url_encode }}"
#         "http://vinyl19-d1/vinyl/app/CLINICALview/BP%20Category%20Data"
#         "/dashboards/21?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
  #    }
  #    link: {
  #      label: "View Target Savings Report"
  #      url: "/dashboards/36?BP%20Category={{ filterable_value | url_encode }}"
#         "/dashboards/24?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
#      }
  #    link: {
  #      label: "View Trending Detail Dashboard"
  #      url:
#         "http://vinyl19-d1/vinyl/app/CLINICALview/Trending%20Detail?BP%20Category={{ filterable_value | url_encode }}"
#         "/dashboards/5?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
  #        "/dashboards/36?BP%20Category={{ filterable_value | url_encode }}"
  #    }
  #  }

  dimension: study_name {
    type: string
    sql: ${TABLE}.StudyName ;;
    label: "BP Category"
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

  dimension: study_name_2 {
    type: string
    sql: ${TABLE}.StudyName ;;
    label: "BP Category"
    link: {
      label: "View Trend Summary Dashboard"
      url: "/dashboards/154?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
#      "/dashboards/36?BP%20Category={{ filterable_value | url_encode }}"
    }
    link: {
      label: "View Trend Detail Dashboard"
      url: "/dashboards/155?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
#      "/dashboards/36?BP%20Category={{ filterable_value | url_encode }}"
    }
    link: {
      label: "View BP Category Data"
      url:  "/dashboards/157?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
#         "/dashboards/F4e5BTmIB2vL0dTu6TGB9d?BP%20Category={{ filterable_value | url_encode }}"
    }
    link: {
      label: "View Target Savings Report"
      url: "/dashboards/153?Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}&Region={{ _filters['bp_facilities.facility_custom_region'] | url_encode }}"
#         "/dashboards/24?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"
    }

  }

  dimension: study_name_with_all_drills{
    view_label: "BP Category Name"
    type: string
    sql: ${TABLE}.StudyName ;;
    label: "BP Category"
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

  dimension: study_owner {
    type: string
    sql: ${TABLE}.StudyOwner ;;
  }

  dimension: study_status_code {
    type: string
    sql: ${TABLE}.StudyStatusCode ;;
  }

  dimension: study_data_source {
    type: string
    sql: ${TABLE}.StudyDataSource ;;
  }

  dimension: study_category {
    type: string
    sql: ${TABLE}.StudyCategory ;;
    label: "BP Portfolio"
  }

  dimension: study_target {
    type: string
    sql: ${TABLE}.StudyTarget ;;
  }

  dimension: study_stat_name {
    label: "Statistic Name"
    type: string
    sql: ${TABLE}.StudyStatName ;;
  }

  dimension: study_label{
    label: "Study Label"
    type: string
    sql: ${TABLE}.StudyStatName ;;
    html: <div style="color: White; background-color:  #00337F; font-size:70%; text-align:Left; padding:60px">
            <div style="height:12px;font-size:1px;">&nbsp;</div>
            <b>BP Category:</b> <i>{{ study_name._linked_value }}</i> <br> <b>Statistic: </b><i>{{ linked_value }}</i></div>;;
  }

  dimension: max_study_end_date{
    type: date
    sql: ${TABLE}.MaxStudyEndDate ;;
    html: {{ rendered_value | date: "%m/%d/%Y" }} ;;
  }

  #  dimension: bp_image {
  #    type: string
  #    sql: ${TABLE}.StudyStatName;;
  #    html: <a href="/dashboards/FTvZmlSkAIhagJZyExhOhE?BP%20Category={{ filterable_value | url_encode }}&Facility={{ _filters['bp_facilities.facility_name'] | url_encode }}"> <img src="https://www.dropbox.com/s/6bvd1ye4tvavkok/Logo.png?dl=0&raw=1" /> ;;
  #   required_access_grants: [clinicalviewadmin]
  #  }


  dimension: bp_image {
    type: string
    sql: ${TABLE}.StudyStatName;;
    html: <img src="https://www.dropbox.com/s/6bvd1ye4tvavkok/Logo.png?dl=0&raw=1" /> ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      study_skey,
      study_name,
      study_owner,
      study_status_code,
      study_data_source,
      study_category,
      study_target,
      study_stat_name
    ]
  }

  set: enduser{
    fields: [
      study_name,
      study_status_code,
      study_category,
      study_stat_name
      ,count
    ]
  }

  set: category_exclusions {
    fields: [
      study_skey
      ,study_owner
      ,study_status_code
      ,study_data_source

    ]
  }
}
