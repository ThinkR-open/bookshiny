#' shinipsum_app UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shinythemes shinytheme
#' @importFrom golem invoke_js
#' @import shinipsum
mod_shinipsum_app_ui <- function(id){
  ns <- NS(id)
  tagList(
    # activate_js(),
    # golem_add_external_resources(),
    fluidPage(title = "Be Indiana !",
              # theme = shinytheme("united"),
              ## Text to explain
              random_text(nwords = 200),
              br(),
              actionButton(ns("start"), "Start !"),
              div(id = ns("data"),
                  style ="display:none",
                  h3("Choose your data"),
                  selectInput(ns("choose_data"),
                              "Choose data",
                              choices = c("iris", "mtcars", "airquality")
                  ),
                  tableOutput(ns("table_data")),
                  actionButton(ns("confirm_choice"), "Confirm !")
              ),
              div(id = ns("explore"),
                  style="display:none",
                  h3("Explore your data"),
                  fluidRow(
                    column(6,
                           mod_shinipsum_app_plot_ui(ns("one"))
                    ),
                    column(6,
                           mod_shinipsum_app_plot_ui(ns("two"))
                    )
                  ),
                  br(),
                  fluidRow(
                    column(6,
                           mod_shinipsum_app_plot_ui(ns("three"))
                    ),
                    column(6,
                           mod_shinipsum_app_plot_ui(ns("four"))
                    )
                  )
              )
    )
  )
}

#' shinipsum_app Server Function
#'
#' @noRd 
mod_shinipsum_app_server <- function(input, output, session){
  ns <- session$ns
  
  local <- reactiveValues()
  
  output$table_data <- renderTable({
    input$choose_data
    random_table(nrow = 10, ncol = 8)
  })
  
  callModule(mod_shinipsum_app_plot_server, "one")   
  callModule(mod_shinipsum_app_plot_server, "two")   
  callModule(mod_shinipsum_app_plot_server, "three")   
  callModule(mod_shinipsum_app_plot_server, "four")   
  
  # JS to show or hide div
  # We will use golem JS
  
  observeEvent( input$start , {
    invoke_js("showid", ns("data"))
    invoke_js("shownid", ns("data"))
    invoke_js("hideid", ns("explore"))
  })
  
  observeEvent( input$confirm_choice , {
    invoke_js("showid", ns("explore"))
    invoke_js("shownid", ns("explore"))
    invoke_js("hideid", ns("data"))
  })
  
}

## To be copied in the UI
# mod_shinipsum_app_ui("shinipsum_app_ui_1")

## To be copied in the server
# callModule(mod_shinipsum_app_server, "shinipsum_app_ui_1")

