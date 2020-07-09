#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    golem::activate_js(),
    # List the first level UI elements here 
    fluidPage(
      h2("Application to show example for 'Engineering Production-Grade Shiny Apps' book"),
      p("These examples cover chapters of the book. They allow you to see examples of more advanced codes."),
      br(),
      br(),
      carousel(height = "600px",
               number_div = 4,
               div_carousel(
                 h2(class = "center", "About using database with shiny"),
                 br(),
                 br(),
                 br(),
                 card_div(
                   class = "card-size",
                   img(src = "www/img/golem.png", class = "img-card"),
                   h4("Please tell us what do you think !"),
                   hr(),
                   a_bttn(text="Go !", href = "http://connect.thinkr.fr/database/")
                 ),
                 active = TRUE
               ),
               div_carousel(
                 h2(class = "center", "About using CSS in shiny"),
                 br(),
                 card_div(
                   class = "card-size",
                   img(src = "www/img/golem.png", class = "img-card"),
                   h4("Using {bs4Dash} package."),
                   hr(),
                   a_bttn("Go !", href = "http://connect.thinkr.fr/bs4dash")
                 ),
                 br(),
                 card_div(
                   class = "card-size",
                   img(src = "www/img/golem.png", class = "img-card"),
                   h4("Using another bootstrap theme."),
                   hr(),
                   a_bttn("Go !", href = "http://connect.thinkr.fr/graysacle")
                 )
                 
               ),
               div_carousel(
                 h2(class = "center", "Quickly and easily design your applications"),
                 br(),
                 br(),
                 br(),
                 card_div(
                   class = "card-size",
                   img(src = "www/img/golem.png", class = "img-card"),
                   h4("Using {shinipsum} package."),
                   hr(),
                   a_bttn("Go !", href = "http://connect.thinkr.fr/shinipsum_book")
                 )
               ),
               div_carousel(
                 h2(class = "center", "About using {future} and {promises}"),
                 br(),
                 card_div(
                   class = "card-size",
                   img(src = "www/img/golem.png", class = "img-card"),
                   h4("Developping classic Shiny App."),
                   hr(),
                   a_bttn("Go !", href = "http://connect.thinkr.fr/without_p_f")
                 ),
                 br(),
                 card_div(
                   class = "card-size",
                   img(src = "www/img/golem.png", class = "img-card"),
                   h4("Developping non-blocking application."),
                   hr(),
                   a_bttn("Go !", href = "http://connect.thinkr.fr/with_f_p")
                 )
                 
               )
      ),
      br(),
      br()
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'bookshiny'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

