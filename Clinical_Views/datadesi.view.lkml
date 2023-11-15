view: bp_datadesignation{
  view_label: "BP Data Designation"
  sql_table_name:dbo.CacheBPdimDataDesignation;;

  dimension: data_designation_skey {
    type: number
    sql: ${TABLE}.DataDesignationSkey ;;
    primary_key: yes
  }

  dimension: data_designation_id {
    type: string
    sql: ${TABLE}.DataDesignationID ;;
  }

  dimension: data_designation_name {
    type: string
    sql: ${TABLE}.DataDesignationName ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [data_designation_skey, data_designation_id, data_designation_name]
  }
  set: bp_datadesignation_exclusions{
    fields: [data_designation_skey, data_designation_id]
  }
}
