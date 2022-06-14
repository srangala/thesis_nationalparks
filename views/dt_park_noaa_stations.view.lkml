view: dt_park_noaa_stations {
  derived_table: {
    sql: SELECT
          ROW_NUMBER() OVER(ORDER BY park_noaa_stations.park_name) id,
          park_noaa_stations.park_name  AS park_name,
          park_noaa_stations.station_id  AS station_id,
          park_noaa_stations.station_name  AS station_name,
          park_noaa_stations.distance AS distance,
              (CASE WHEN park_noaa_stations.closest_station  THEN 'Yes' ELSE 'No' END) AS closest_station
      FROM `national_parks.parks` AS parks
          LEFT JOIN `national_parks.park_noaa_stations`
           AS park_noaa_stations
           ON parks.park_name = park_noaa_stations.park_name
      ORDER BY
          1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: park_name {
    type: string
    sql: ${TABLE}.park_name ;;
  }

  dimension: station_id {
    type: string
    sql: ${TABLE}.station_id ;;
  }

  dimension: station_name {
    type: string
    sql: ${TABLE}.station_name ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
    value_format: "0.00"
  }

  dimension: closest_station {
    type: string
    sql: ${TABLE}.closest_station ;;
  }

  set: detail {
    fields: [
      id,
      park_name,
      station_id,
      station_name,
      distance,
      closest_station
    ]
  }
}
