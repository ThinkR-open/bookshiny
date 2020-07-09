#' unit_test UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_unit_test_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Testing application"),
    p("One of the harder think about shiny it to maintain the application.", 
      br(),
      "To make this easier, we will use unit tests. The goal will be to create scenarios to check the correct behavior of our application."),
    p("Also, unit tests are good to test your buisness logic."),
    br(),
    card_div(
      p("Two examples with different methods on the shinipsum part of the application."),
      column(6, 
             h4("Using {crrry}")
             ),
      column(6,
             h4("Using puppeteer, the node package")
             )
    )
  )
}
    
#' unit_test Server Function
#'
#' @noRd 
mod_unit_test_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_unit_test_ui("unit_test_ui_1")
    
## To be copied in the server
# callModule(mod_unit_test_server, "unit_test_ui_1")
 
