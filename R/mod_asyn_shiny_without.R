#' asyn_shiny_without UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom dplyr %>% sample_n
mod_asyn_shiny_without_ui <- function(id){
  ns <- NS(id)
  tagList(
    golem::activate_js(),
    golem_add_external_resources(),
    back_home(ns("home")),
    h2("Classic shiny application without useing {promises and future}"),
    p("This is a small example to show the bloking process of R.",
      br(),
      "Click on genrate button, you will see that your application is busy and can't do nothing else.", 
      br(),
      "It's illustrated by the message. In a common use of shiny, this message doesn't appear and yet the R server is well calculated and it can't do anything else."),
    fluidPage(
      fluidRow(
        column(6,
               card_div(
                 p("When you click on the button, it takes 5 second to generate this graphic."),
                 actionButton(
                   ns("generate"),
                   "Generate !"
                 ),
                 plotOutput(
                   ns("graph")
                 )
               )
        ),
        column(6,
               card_div(
                 sliderInput(
                   ns("lignes"),
                   label = "Select random number of lines",
                   min = 5,
                   max = 10,
                   value = 5
                 ),
                 tableOutput(
                   ns("table")
                 )
               )
        )
      ),
      br(),
      fluidRow(
        a_bttn(
          "See what's happen with {promises} and {future}",
          href = "http://connect.thinkr.fr/with_f_p")
      )
    )
  )
}

#' asyn_shiny_without Server Function
#'
#' @noRd 
mod_asyn_shiny_without_server <- function(input, output, session){
  ns <- session$ns
  
  local <- reactiveValues()
  
  observeEvent( input$generate , {
    ## Simulate long process
    showNotification(
      p("Your application is blocked by the generation of the graphic"),
      closeButton = FALSE)
    
    Sys.sleep(5)
    
    local$plot <- shinipsum::random_ggplot()
    
  })
  
  observeEvent( input$lignes , {
    local$table <-  iris %>%
      sample_n(input$lignes)
  })
  
  
  output$graph <- renderPlot({
    local$plot
  })
  
  output$table <- renderTable({
    local$table
  })
}

## To be copied in the UI
# mod_asyn_shiny_without_ui("asyn_shiny_without_ui_1")

## To be copied in the server
# callModule(mod_asyn_shiny_without_server, "asyn_shiny_without_ui_1")

