# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
devtools::document()
devtools::load_all()

# Run the application
library(shiny)
# library(future)
# library(promises)
# plan(multisession)
ui <- fluidPage(
  # golem_add_external_resources(),
  mod_asyn_shiny_without_ui("async")
)

server <- function(input, output, session) {
  
  
  callModule(mod_asyn_shiny_without_server, "async")
}

shinyApp(ui, server)

