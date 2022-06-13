view: dt_park_climate {
  derived_table: {
    sql: SELECT
        park_climate.park  AS park,
        park_climate.month  AS month,
        CASE park_climate.month
        WHEN "January" THEN 1
        WHEN "February" THEN 2
        WHEN "March" THEN 3
        WHEN "April" THEN 4
        WHEN "May" THEN 5
        WHEN "June" THEN 6
        WHEN "July" THEN 7
        WHEN "August" THEN 8
        WHEN "September" THEN 9
        WHEN "October" THEN 10
        WHEN "November" THEN 11
        WHEN "December" THEN 12
        END AS num_month,
        park_climate.avg_tmp_high AS avg_tmp_high,
        park_climate.avg_tmp_low AS avg_tmp_low
    FROM `national_parks.parks`
         AS parks
    LEFT JOIN `national_parks.park_climate`
         AS park_climate ON parks.park_name = park_climate.park
    GROUP BY
        1,
        2,
        3,
        4,
        5
    ORDER BY
        3
     ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    primary_key: yes
    sql: CONCAT(${TABLE}.park, ${TABLE}.month) ;;
    hidden: yes
  }

  dimension: park {
    type: string
    sql: ${TABLE}.park ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: num_month {
    type: number
    sql: ${TABLE}.num_month ;;
  }

  dimension: avg_tmp_high {
    type: number
    sql: ${TABLE}.avg_tmp_high ;;
  }

  dimension: avg_tmp_low {
    type: number
    sql: ${TABLE}.avg_tmp_low ;;
  }

  measure: measure_avg_tmp_high {
    type: average
    sql: ${avg_tmp_high} ;;
  }

  measure: measure_avg_tmp_low {
    type: average
    sql: ${avg_tmp_low} ;;
  }

  set: detail {
    fields: [
      park,
      month,
      num_month,
      avg_tmp_high,
      avg_tmp_low
    ]
  }
}
