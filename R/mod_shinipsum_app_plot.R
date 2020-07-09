#' shinipsum_app_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_shinipsum_app_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "box",
    fluidRow(
      column(6,
             selectInput(ns("col_one"), "choose the x-axis", choices = names(iris))
      ),
      column(6,
             selectInput(ns("col_two"), "choose the y-axis", choices = names(iris))
      )
    ),
    plotOutput(ns("plot"))
  )
  )
}

#' shinipsum_app_plot Server Function
#'
#' @noRd 
mod_shinipsum_app_plot_server <- function(input, output, session){
  ns <- session$ns
  
  output$plot <- renderPlot({
    input$col_one
    input$col_two
    random_ggplot()
  })
  
}

## To be copied in the UI
# mod_shinipsum_app_plot_ui("shinipsum_app_plot_ui_1")

## To be copied in the server
# callModule(mod_shinipsum_app_plot_server, "shinipsum_app_plot_ui_1")

