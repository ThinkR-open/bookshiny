#' database_app_question UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import ggplot2 
#' @importFrom  magrittr %>% 
mod_database_app_question_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Tell us what do you ThinkR about this book !"),
    actionButton(ns('go'), 'With pleasure !') %>%
      htmltools::tagAppendAttributes(
        onclick = sprintf("$( '#%s' ).slideToggle( 'fast' );", ns("form"))
      ),
    # br(),
    refresh(ns('refresh'), ns("msg_refresh")),
    div(id = ns("form"), 
        class = "card-book none",
        fluidRow(
          column(4,
                 sliderInput(ns("note"),
                             "Give a great",
                             min = 0,
                             max = 10,
                             value = 5)),
          column(4,
                 radioButtons(inputId = ns('level'),
                              inline = TRUE,
                              label = "How long have you been using {shiny}?",
                              choices = list("Less then 6 months" = "less6month" ,
                                             "6 to 12 months" = "6to12",
                                             "More then 12 months" = "more12"))),
          column(4,
                 radioButtons(ns("times"),
                              inline = TRUE,
                              label = "How many times a week do you work with {shiny}?",
                              choices = list("Every days" = "everyday",
                                             "4 or 5 times" = "4or5",
                                             "2 or 3 times" = "2or3",
                                             "Only one" = "only1"))
          )
        ),
        br(),
        br(),
        fluidRow(
          column(4,
                 selectInput(ns("chapter_too_much"),
                             "Which chapters are, in your opinion, too detailed?",
                             choices = letters,
                             multiple = TRUE)
          ),
          column(4,
                 selectInput(ns("chapter_not_enough"),
                             "In your opinion, which chapters are not detailed enough?",
                             choices = letters,
                             multiple = TRUE)
          ),
          column(4,
                 textAreaInput(ns("missing"),
                               "What topics are missing from this book?")
          )
        ),
        fluidRow(
          actionButton(ns("confirm"), "Confirm !") 
        )
    ),
    br(),
    h2("Analysis"),
    card_div(
      h3("Scoring distribution"),
      plotOutput(ns("plot_note")),
      h3("Level distribution"),
      plotOutput(ns("plot_level")),
      h3("Time distribution"),
      plotOutput(ns("plot_times")),
      h3("Chapter too detailed"),
      plotOutput(ns("plot_ctm")),
      h3("Chapter not detailed enough"),
      plotOutput(ns("plot_cne"))
    ),
    br(),
    heart(ns("thanks"))
    
  )
}

#' database_app_question Server Function
#'
#' @noRd 
mod_database_app_question_server <- function(input, output, session, r, connect){
  ns <- session$ns
  
  local <- reactiveValues(data = if(!is.null(connect$con)){dbReadTable(connect$con, "answers")} )
  
  observeEvent( input$confirm , {
    showModal(
      modal_confirm()
    )
  })
  

  
  observeEvent( input$ok , {
    removeModal()
    if(is.null(connect$con)){
      golem::invoke_js("succes", "error")
    }
    req(connect$con)
    df <- data.frame(great = null_to_na(input$note),
                     level = null_to_na(input$level),
                     time = null_to_na(input$times),
                     chapter_too_much = null_to_na(input$chapter_too_much),
                     chapter_not_enough = null_to_na(input$chapter_not_enough),
                     missing = null_to_na(input$missing))
    
    if(!"answers" %in% DBI::dbListTables(connect$con)){
      DBI::dbWriteTable(connect$con, "answers", df)
    }
    DBI::dbAppendTable(connect$con, "answers", df)
    
    golem::invoke_js("succes", ns("thanks"))
    
  })
  
  observeEvent( input$no , {
    removeModal()
  })
  

  observeEvent( input$refresh , {
    req(connect$con)
    local$data <- dbReadTable(connect$con, "answers")
    message("Data refresh !!")
    golem::invoke_js("succes", ns("msg_refresh"))
  })
  
  output$plot_note <- renderPlot({
    not_validate(!is.null(connect$con), msg = "Needs to be connect to the database!")
    plot_db(local$data, "great")
  })
  
  output$plot_level <- renderPlot({
    not_validate(!is.null(connect$con), msg = "Needs to be connect to the database!")
    plot_db(local$data, "level")
  })
  
  output$plot_times <- renderPlot({
    not_validate(!is.null(connect$con), msg = "Needs to be connect to the database!")
    plot_db(local$data, "time")
  })
  
  output$plot_ctm <- renderPlot({
    not_validate(!is.null(connect$con), msg = "Needs to be connect to the database!")
    plot_db(local$data, "chapter_too_much")
  })
  
  output$plot_cne <- renderPlot({
    not_validate(!is.null(connect$con), msg = "Needs to be connect to the database!")
    plot_db(local$data, "chapter_not_enough")
  })
  
}

## To be copied in the UI
# mod_database_app_question_ui("database_app_question_ui_1")

## To be copied in the server
# callModule(mod_database_app_question_server, "database_app_question_ui_1")

