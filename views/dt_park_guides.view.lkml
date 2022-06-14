view: dt_park_guides {
  derived_table: {
    sql: WITH non_dupl_guides AS
            (
            SELECT * FROM
            (SELECT
                guides.park  AS park_code,
                guides.link  AS link,
                guides.feature  AS feature,
                guides.description  AS description,
                ROW_NUMBER() OVER(PARTITION BY guides.park,guides.link,guides.feature,guides.description ORDER BY 1,2,3,4 DESC) AS rownumber
            FROM `national_parks.guides`  AS guides) AS guides_
            WHERE
              rownumber = 1  /*to eliminate duplicate rows (guides.feature = 'Badlands Astronomy Festival', 'Badlands Ranger Programs','GPS Adventure', 'Become a Badlands Junior Ranger', 'Drive Sage Creek Rim Road')*/
            )
            SELECT
              parks.park_name as park_name,
              non_dupl_guides.park_code,
              non_dupl_guides.link,
              non_dupl_guides.feature,
              non_dupl_guides.description,
              ROW_NUMBER() OVER(ORDER BY 1,2,3,4,5) id
            FROM `national_parks.parks` AS parks
            JOIN non_dupl_guides --inner join, in order to not show empty guide records
              ON parks.park_code = non_dupl_guides.park_code
             ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: park_name {
    type: string
    sql: ${TABLE}.park_name ;;
  }

  dimension: park_code {
    type: string
    sql: ${TABLE}.park_code ;;
  }

  dimension: link {
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: feature {
    type: string
    sql: ${TABLE}.feature ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  set: detail {
    fields: [
      park_name,
      park_code,
      link,
      feature,
      description,
      id
    ]
  }
}
