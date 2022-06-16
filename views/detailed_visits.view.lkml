# The name of this view in Looker is "Detailed Visits"
view: detailed_visits {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `national_parks.detailed_visits`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Backcountry Campers" in Explore.

  parameter: select_measure_parameter {
    type: unquoted
    allowed_value: {label: "Backcountry Campers" value:"backcountry_campers"}
    allowed_value: {label: "RV Campers" value:"rv_campers"}
    allowed_value: {label: "Tent Campers" value:"tent_campers"}
    allowed_value: {label: "Misc Campers" value:"misc_campers"}
  }

  dimension: id {
    primary_key: yes
    sql: CONCAT(${TABLE}.park, ${TABLE}.month, ${TABLE}.year) ;;
    hidden: yes
  }

  dimension: backcountry_campers {
    type: number
    sql: ${TABLE}.backcountry_campers ;;
    html: {% if select_measure_parameter._parameter_value == 'backcountry_campers' %}
            <p style="color: black; background-color: yellow; font-size:100%;">{{ rendered_value }}</p>
          {% else %}
            <p>{{ rendered_value }}</p>
         {% endif %};;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_backcountry_campers {
    type: sum
    sql: ${backcountry_campers} ;;
  }

  measure: average_backcountry_campers {
    type: average
    sql: ${backcountry_campers} ;;
    drill_fields: [park, year, month, backcountry_campers]
  }

  measure: total_misc_campers {
    type: sum
    sql: ${misc_campers} ;;
  }

  measure: total_tent_campers {
    type: sum
    sql: ${tent_campers} ;;
  }

  measure: total_rv_campers {
    type: sum
    sql: ${rv_campers} ;;
  }

  measure: dynamic_measure {
    type: number
    sql: {% if select_measure_parameter._parameter_value == 'backcountry_campers' %}
            ${total_backcountry_campers}
         {% elsif select_measure_parameter._parameter_value == 'rv_campers' %}
            ${total_rv_campers}
         {% elsif select_measure_parameter._parameter_value == 'tent_campers' %}
            ${total_tent_campers}
         {% else %}
            ${total_misc_campers}
         {% endif %};;
    drill_fields: [park, year, month, backcountry_campers, rv_campers, tent_campers, misc_campers]
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
  }

  dimension: concession_camping {
    type: number
    sql: ${TABLE}.concession_camping ;;
  }

  dimension: concession_lodging {
    type: number
    sql: ${TABLE}.concession_lodging ;;
  }

  dimension: misc_campers {
    type: number
    sql: ${TABLE}.misc_campers ;;
    html: {% if select_measure_parameter._parameter_value == 'misc_campers' %}
    <p style="color: black; background-color: yellow; font-size:100%;">{{ rendered_value }}</p>
    {% else %}
    <p>{{ rendered_value }}</p>
    {% endif %};;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: non_recreation_hours {
    type: number
    sql: ${TABLE}.non_recreation_hours ;;
  }

  dimension: non_recreation_overnight_stays {
    type: number
    sql: ${TABLE}.non_recreation_overnight_stays ;;
  }

  dimension: non_recreation_visitors {
    type: number
    sql: ${TABLE}.non_recreation_visitors ;;
  }

  dimension: park {
    type: string
    sql: ${TABLE}.park ;;
  }

  dimension: recreation_hours {
    type: number
    sql: ${TABLE}.recreation_hours ;;
  }

  dimension: recreation_visitors {
    type: number
    sql: ${TABLE}.recreation_visitors ;;
  }

  dimension: rv_campers {
    type: number
    sql: ${TABLE}.rv_campers ;;
    html: {% if select_measure_parameter._parameter_value == 'rv_campers' %}
    <p style="color: black; background-color: yellow; font-size:100%;">{{ rendered_value }}</p>
    {% else %}
    <p>{{ rendered_value }}</p>
    {% endif %};;
  }

  dimension: tent_campers {
    type: number
    sql: ${TABLE}.tent_campers ;;
    html: {% if select_measure_parameter._parameter_value == 'tent_campers' %}
    <p style="color: black; background-color: yellow; font-size:100%;">{{ rendered_value }}</p>
    {% else %}
    <p>{{ rendered_value }}</p>
    {% endif %};;
  }

  dimension: total_overnight_stays {
    type: number
    sql: ${TABLE}.total_overnight_stays ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
