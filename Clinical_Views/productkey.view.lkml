view: bp_productkey{
  view_label: "BP Product Key"
  sql_table_name: dbo.CacheBPdimProductKey;;

  dimension: product_key_skey {
    type: number
    sql: ${TABLE}.ProductKeySkey ;;
    primary_key: yes
  }

  dimension: product_key_id {
    type: string
    sql: ${TABLE}.ProductKeyID ;;
  }

  dimension: product_key_name {
    type: string
    sql: ${TABLE}.ProductKeyName ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [product_key_skey, product_key_id, product_key_name]
  }
  set: bp_productkey_exclusions{
    fields: [product_key_skey, product_key_id]
  }
}
