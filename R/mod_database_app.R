#' database_app UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import DBI 
mod_database_app_ui <- function(id){
  ns <- NS(id)
  tagList(
    golem_add_external_resources(),
    activate_js(),
    back_home("home"),
    fluidPage(
      back_home(id = ns("home")),
      h2("Database example"),
      p("In this application, we are using Postgre database."),
      hr(),
      tabsetPanel(type = "pills",
                  tabPanel("Livre d'or",
                           mod_database_app_livredor_ui(ns("livredor"))
                  ),
                  tabPanel("Give more details",
                           mod_database_app_question_ui(ns("question"))
                  )
      )
    ),
    toasts()
    )
}

#' database_app Server Function
#'
#' @noRd 
mod_database_app_server <- function(input, output, session){
  ns <- session$ns
  
  local <- reactiveValues()
  
  ### Connect to the database
  connect <- connect_db()
  
  observeEvent(connect,{
    if(connect$connect){
      golem::invoke_js("succes", "succes")
      table <- dbListTables(connect$con)
      if(length(table) == 0){
        df <- data.frame("date" = "", "feedback"= "", "emoji" = "")
        dbCreateTable(connect$con, "feedback", df)
        local$data <- df
      }else{
        local$data <- dbReadTable(connect$con, "feedback")
      }
      
    }else{
      golem::invoke_js("succes", "error")
    }
  })
  
  callModule(mod_database_app_livredor_server, "livredor", r = local, connect = connect)
  callModule(mod_database_app_question_server, "question", r = local, connect = connect)
  
  # shiny::onSessionEnded(DBI::dbDisconnect(connect$con))
}

## To be copied in the UI
# mod_database_app_ui("database_app_ui_1")

## To be copied in the server
# callModule(mod_database_app_server, "database_app_ui_1")

