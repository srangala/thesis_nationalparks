# Define the database connection to be used for this model.
connection: "national_parks"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: nationalparks_srangala_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: nationalparks_srangala_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Nationalparks Srangala"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

#explore: park_noaa_stations {}
#explore: detailed_weather {}
#explore: guides {}
#explore: detailed_climate {}

explore: detailed_visits {}
explore: park_climate {}
explore: climbing {}
explore: trails {}
explore: park_species {}

explore: parks {
  join: park_species {
    type: left_outer
    sql_on: ${parks.park_name} = ${park_species.park_name};;
    relationship: one_to_many
  }
  join: detailed_visits {
    type: left_outer
    sql_on: ${parks.park_name} = ${detailed_visits.park};;
    relationship: one_to_many
  }
  join: trails {
    type: left_outer
    sql_on: ${parks.park_name} = ${trails.area_name};;
    relationship: one_to_many
  }
  join: dt_park_climate {
    view_label: "Park Climate"
    type: left_outer
    sql_on: ${parks.park_name} = ${dt_park_climate.park};;
    relationship: one_to_many
  }
  join: climbing {
    type: left_outer
    sql_on: ${parks.park_name} = ${climbing.park};;
    relationship: one_to_many
  }
}

#this view has almost same fields as detailed_visits, this last one also has a comments field
#explore: monthly_visits {}
