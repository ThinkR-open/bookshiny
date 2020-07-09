# Set options here
options(golem.app.prod = TRUE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()
pkgload::load_all()

# Run the application
library(shiny)
library(golem)

ui <- fluidPage(
  mod_database_app_ui("ok")
)

server <- function(input, output, session) {
  callModule(mod_database_app_server, "ok")
}

shinyApp(ui, server)
