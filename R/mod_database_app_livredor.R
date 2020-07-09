#' database_app_livredor UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_database_app_livredor_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Make us happy, give us your feedback !"),
    actionButton(ns("feedback"), "Yes, let's go !"),
    refresh(ns('refresh'), ns("msg_refresh")),
    DT::DTOutput(ns("comms"))
  )
  
}

#' database_app_livredor Server Function
#'
#' @noRd 
mod_database_app_livredor_server <- function(input, output, session, r, connect){
  ns <- session$ns
  local <- reactiveValues()
  
  observeEvent( r$data , {
    local$data <- r$data
  })
  
  observeEvent( input$feedback , {
    showModal(
      modalDialog(
        title = "Tell us everything !",
        tagList(
          textAreaInput(ns("comms_txt"), label = ""),
          selectInput(ns("great"), "Give us a smiley", choices = emo::jis$emoji),
          actionButton(ns("validate"), "Submit !")
        )
      )
    )
  })
  
  observeEvent( input$validate , {
    removeModal()
    if(is.null(connect$con)){
      golem::invoke_js("succes", "error")
    }
    req(connect$con)
    df <- data.frame(date = as.character(lubridate::today()), feedback = input$comms_txt, emoji = input$great)
    dbAppendTable(connect$con, "feedback", df)
    local$data <- dbReadTable(connect$con, "feedback")
  })
  
  observeEvent( input$refresh , {
    req(connect$con)
    local$data <- dbReadTable(connect$con, "feedback")
    message("Data refresh !!")
    golem::invoke_js("succes", ns("msg_refresh"))
  })
  
  
  output$comms <- DT::renderDT({
    not_validate(!is.null(connect$con), msg = "Needs to be connect to the database!")
    local$data %>%
      dplyr::mutate(date = lubridate::ymd(date)) %>%
      dplyr::arrange(dplyr::desc(date))
  }, 
  rownames = FALSE,
  options = list(lengthChange = FALSE, dom = 'tp')
  )
}

## To be copied in the UI
# mod_database_app_livredor_ui("database_app_livredor_ui_1")

## To be copied in the server
# callModule(mod_database_app_livredor_server, "database_app_livredor_ui_1")

