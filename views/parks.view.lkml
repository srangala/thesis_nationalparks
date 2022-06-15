# The name of this view in Looker is "Parks"
view: parks {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `national_parks.parks`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Acres" in Explore.

  dimension: acres {
    type: number
    sql: ${TABLE}.Acres ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_acres {
    type: sum
    sql: ${acres} ;;
  }

  measure: average_acres {
    type: average
    sql: ${acres} ;;
  }

  dimension: art {
    label: "Art Link"
    type: string
    sql: ${TABLE}.Art ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: click_to_see_image {
    type: string
    sql: ${TABLE}.Art ;;
    html:
    <details>
    <summary>Click to see image</summary>
    <p><img height="100" src="{{ value }}"></img></p>
    </details> ;;
  }

  dimension: art_image {
    type: string
    sql: ${TABLE}.Art ;;
    html: <img height="450" src="{{ value }}" /> ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: est_annual_visitors {
    type: number
    sql: ${TABLE}.est_annual_visitors ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: established {
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
    sql: ${TABLE}.established ;;
  }

  dimension: park_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.Latitude ;;
    hidden: yes
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
    hidden: yes
  }

  dimension: park_code {
    type: string
    sql: ${TABLE}.Park_Code ;;
  }

  dimension: park_name {
    type: string
    sql: ${TABLE}.park_name ;;
    primary_key: yes
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: world_heritage_site {
    type: yesno
    sql: ${TABLE}.world_heritage_site ;;
  }

  measure: count {
    type: count
    drill_fields: [park_name]
  }
}
