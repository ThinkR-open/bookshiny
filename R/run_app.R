#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  ...
) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}


#' Run CSS bs4dash Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app_css_bs4dash <- function(
  ...
) {
  app_ui <- fluidPage(
    mod_css_bs4dash_ui('css')
  )
  app_server <- function( input, output, session ) {
    # List the first level callModules here
    callModule(mod_css_bs4dash_server, "css")
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}

#' Run CSS bs4dash Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app_css_graysacle <- function(
  ...
) {
  app_ui <- fluidPage(
    mod_css_another_ui('css')
  )
  app_server <- function( input, output, session ) {
    # List the first level callModules here
    callModule(mod_css_another_server, "css")
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}


#' Run database Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app_database <- function(
  ...
) {
  app_ui <- fluidPage(
    mod_database_app_ui("ok")
  )
  
  app_server <- function(input, output, session) {
    callModule(mod_database_app_server, "ok")
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}


#' Run shinispum Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app_shinipsum <- function(
  ...
) {
  app_ui <- fluidPage(
    mod_shinipsum_ui("ok")
  )
  
  app_server <- function(input, output, session) {
    callModule(mod_database_app_server, "ok")
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}


#' Run blocking Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app_without_p_f <- function(
  ...
) {
  app_ui <- fluidPage(
    mod_asyn_shiny_without_ui("ok")
  )
  
  app_server <- function(input, output, session) {
    callModule(mod_asyn_shiny_without_server, "ok")
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}

#' Run non-blocking Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app_with_p_f <- function(
  ...
) {
  app_ui <- fluidPage(
    mod_asyn_shiny_with_ui("ok")
  )
  
  app_server <- function(input, output, session) {
    callModule(mod_asyn_shiny_with_server, "ok")
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}