#' shinipsum UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_shinipsum_ui <- function(id){
  ns <- NS(id)
  tagList(
    golem_add_external_resources(),
    activate_js(),
    back_home(ns("home")),
    h2("Using {shinipsum}"),
    p("To design your application fast, a good way is to use {shinipsum} package",
      br(),
      "Let's imagine that we have to propose the UI of the application (remember that you have to fix this UI before coding the server)."),
    br(),
    actionButton(ns("design_brief"),
                 "Click here to see the design brief !"),
    br(),
    br(),
    br(),
    ## TODO design brief
    card_div(
      mod_shinipsum_app_ui(ns("shinipsum"))
    ),
    br()
  )
}

#' shinipsum Server Function
#'
#' @noRd 
mod_shinipsum_server <- function(input, output, session){
  ns <- session$ns
  callModule(mod_shinipsum_app_server, "shinipsum")
  
  observeEvent( input$design_brief , {
    showModal(
      modalDialog(
        title = "Brief !",
        easyClose = TRUE,
        p(style = "text-align:justify;","For this application, a first explanation text is required. Then the person will be able to choose a data set. After having made this choice, he will be able to observe in 4 boxes the relation between the different variables")
      )
    )
  })
  
}

## To be copied in the UI
# mod_shinipsum_ui("shinipsum_ui_1")

## To be copied in the server
# callModule(mod_shinipsum_server, "shinipsum_ui_1")

