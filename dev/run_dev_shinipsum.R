# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()
devtools::load_all()

# Run the application
library(shiny)
library(golem)

ui <- fluidPage(
  mod_shinipsum_ui("ok")
)

server <- function(input, output, session) {
  callModule(mod_shinipsum_server, "ok")
}

shinyApp(ui, server)
