view: analysis_desi_key_master {
  view_label: "BP Classifications"
  sql_table_name: dbo.AnalysisDesiKeyMaster ;;

  dimension: analysis_skey {
    type: number
    sql: ${TABLE}.AnalysisSkey ;;
  }

  dimension: data_designation_name {
    type: string
    sql: ${TABLE}.DataDesignationName ;;
    label: "Product Type"
  }

  dimension: data_designation_skey {
    type: number
    sql: ${TABLE}.DataDesignationSkey ;;
  }

  dimension: desi_rollup_skey {
    type: number
    sql: ${TABLE}.DesiRollupSKey ;;
  }

  dimension: prodkey_rollup_skey {
    type: number
    sql: ${TABLE}.ProdkeyRollupSKey ;;
  }

  dimension: product_key_name {
    type: string
    sql: ${TABLE}.ProductKeyName ;;
    label: "Product Detail"
  }

  dimension: product_key_skey {
    type: number
    sql: ${TABLE}.ProductKeySkey ;;
  }

  measure: count {
    type: count
    drill_fields: [data_designation_name, product_key_name]
  }

  set: enduser{
    fields: [
      product_key_name,
      data_designation_name
      ,count
    ]
  }

}
