# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()
pkgload::load_all()

# Run the application
library(shiny)

ui <- fluidPage(
  # golem_add_external_resources(),
  mod_css_another_ui("css")
)

server <- function(input, output, session) {
  callModule(mod_css_another_server, "css")
}

shinyApp(ui, server)
