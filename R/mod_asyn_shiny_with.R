#' asyn_shiny_with UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom future future plan multisession
#' @import promises
mod_asyn_shiny_with_ui <- function(id) {
  ns <- NS(id)
  tagList(
    golem::activate_js(),
    golem_add_external_resources(),
    back_home(ns("home")),
    h2("Shiny application useing {promises and future}"),
    p("Click on genrate button, you will see that you can steel using the application !"),
    br(),
    fluidPage(
      fluidRow(
        column(
          6,
          card_div(
            p("When you click on the button, it takes 5 second to generate this graphic."),
            actionButton(ns("generate"), "Generate !"),
            plotOutput(ns("graph"))
          )
        ),
        column(
          6,
          card_div(
            sliderInput(
              ns("lignes"),
              label = "Select random number of lines",
              min = 5,
              max = 10,
              value = 5
            ),
            tableOutput(ns("table"))
          )
        )
      ),
      br(),
      fluidRow(
        a_bttn(
          "See what's happen without {promises} and {future}",
          href = "http://connect.thinkr.fr/without_p_f"
        )
      )
    ) # ,
    # shiny_busy_not_blocking(id = ns("async_shiny"))
  )
}

#' asyn_shiny_with Server Function
#'
#' @noRd
mod_asyn_shiny_with_server <- function(input, output, session) {
  ns <- session$ns

  future::plan(future::multisession)

  local <- reactiveValues()

  observeEvent(
    input$generate,
    {
      ## Simulate long process

      future({
        Sys.sleep(5)
        shinipsum::random_ggplot()
      }) %...>%
        (function(e) {
          local$plot <- e
        }) %...!%
        (function(e) {
          warning(e)
        })

      showNotification(
        p("The graphic is calculated but you can still use the application"),
        closeButton = FALSE
      )

      message("Done !")
    },
    ignoreInit = TRUE
  )

  observeEvent(input$lignes, {
    local$table <- iris %>%
      sample_n(input$lignes)
  })


  output$graph <- renderPlot({
    req(local$plot)
    local$plot
  })

  output$table <- renderTable({
    local$table
  })
}

## To be copied in the UI
# mod_asyn_shiny_with_ui("asyn_shiny_with_ui_1")

## To be copied in the server
# callModule(mod_asyn_shiny_with_server, "asyn_shiny_with_ui_1")
