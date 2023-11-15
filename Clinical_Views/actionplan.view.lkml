view: bp_actionplan{
  view_label: "BP Action Plan"
  sql_table_name: dbo.CacheBPdimActionPlan ;;


  dimension: ai_id {
    type: number
    sql: ${TABLE}.AI_ID ;;
    primary_key: yes
  }

  dimension: action_item {
    type: string
    sql: ${TABLE}.Action_Item ;;
    html: {% if bp_actionplan.text_position._value == 0 and bp_actionplan.text_item_order._value == 1 %}
              <p><big>☐  </big>{{ value }}</p>
              {% else %}
              <p></p>
              {% endif %};;
  }

  dimension: ai_calc_id {
    type: number
    sql: ${TABLE}.AI_Calc_ID ;;
  }

  dimension: ai_skey {
    type: number
    sql: ${TABLE}.AI_Skey ;;
  }

  dimension: aic_sub_skey {
    type: string
    sql: ${TABLE}.AIC_Sub_Skey ;;
  }

  dimension: ait_sub_skey {
    type: string
    sql: ${TABLE}.AIT_Sub_Skey ;;
  }

  dimension: calc_item_order {
    type: number
    sql: ${TABLE}.Calc_Item_Order ;;
  }

  dimension: calc_position {
    type: number
    sql: ${TABLE}.Calc_Position ;;
  }

  dimension: clean_action_text_indent{
    type: string
    sql:
           CASE   WHEN ${text_position} = '0' AND ${text_item_order} = '1'
                  THEN ${clean_action_text}
                  WHEN ${text_position} = '0' AND ${text_item_order} <> '1'
                  THEN ${clean_action_text_nobox}
                  WHEN ${text_position} = '1'
                  THEN ${clean_action_text_1}
                  WHEN ${text_position} = '2'
                  THEN ${clean_action_text_2}
                  END;;
  }

  dimension: clean_action_text_final{
    type: string
    sql: ${clean_action_text};;
    html: {% if bp_actionplan.text_position._value == 0 and bp_actionplan.text_item_order._value == 1 %}
          <p>{{ value }}</p>
          {% elsif bp_actionplan.text_position._value == 0 and bp_actionplan.text_item_order._value <> 1 %}
          <p>{{ value }}</p>
          {% elsif bp_actionplan.text_position._value == 1 and bp_actionplan.text_item_order._value <> 0 %}
          <p>&nbsp;&nbsp;&nbsp;{{ value }}</p>
          {% elsif bp_actionplan.text_position._value == 2 and bp_actionplan.text_item_order._value <> 0  %}
          <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{ value }}</p>
          {% else %}
          {{ value }}
          {% endif %};;
  }

  dimension: clean_action_text_nobox{
    type: string
    sql: ${TABLE}.Clean_Action_Text ;;
  }

  dimension: clean_action_text_1{
    type: string
    sql:CONCAT('--',${clean_action_text_nobox});;
  }

  dimension: clean_action_text_2{
    type: string
    sql:CONCAT('-----',${clean_action_text_nobox});;
  }

  dimension: clean_action_text {
    type: string
    sql: ${TABLE}.Clean_Action_Text ;;
#     html:  <big>☐</big> {{ clean_action_text._value }} ;;
  }

  dimension: clean_calc_text {
    type: string
    sql: isnull(${TABLE}.Clean_Calc_Text, '') ;;
  }

  dimension: calculation_and_action {
    description: "clean_calc_text and clean_action_text concatenated together with HTML fomatting to be in a table"
    type: string
    sql: concat(${clean_calc_text}, ' ', ${clean_action_text_indent}) ;;
    html:
      <table>
        <tr>
            <td style="width:500px; height:5%">{{ clean_calc_text._value }}</td>
            <td style="width:500px; height:5%"><big>☐</big> {{ clean_action_text_indent._value }}</td>
        </tr>
      </table>
      ;;
  }

#     html:
#   <table>
#     <tr>
#         <td style="width:50%; height:50px">{{ clean_calc_text._value }}</td>
#         <td style="width:50%; height:50px">{{ clean_action_text._value }}</td>
#     </tr>
#   </table>
#         ;;


  dimension: facility_skey {
    type: number
    sql: ${TABLE}.Facility_Skey ;;
  }

  dimension: study_skey {
    type: number
    sql: ${TABLE}.Study_Skey ;;
  }

  dimension: text_item_number {
    type: number
    sql: ${TABLE}.Text_Item_Number ;;
  }

  dimension: text_item_order {
    type: number
    sql: ${TABLE}.Text_Item_Order ;;
  }

  dimension: text_position {
    type: number
    sql: ${TABLE}.Text_Position ;;
  }

  dimension: ya_action_text {
    type: string
    sql: ${TABLE}.ya_ActionText ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
