view: bp_security{
  view_label: "BP Security"
  sql_table_name: dbo.lookBPSecurity
    ;;

  dimension: security_record_id {
    type: string
    sql: ${TABLE}.SecurityRecordID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.UserID ;;
    hidden: yes
  }

  dimension: member_skey {
    type: number
    sql: ${TABLE}.MemberSkey ;;
    hidden: yes
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.AccountID ;;
    hidden: yes
  }

  dimension: demo_user{
    type: number
    sql: ${TABLE}.IsDemo ;;
  }

  dimension: display{
    type: number
    sql: ${TABLE}.Display ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  set: detail {
    fields: [
      user_id
      ,member_skey
      ,account_id
      ,security_record_id]
  }
}
