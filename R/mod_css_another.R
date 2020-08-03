#' css_another UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
mod_css_another_ui <- function(id){
  ns <- NS(id)
  tagList(
    back_home(ns("home")),
    h2("Illustration about adding CSS"),
    p("We have implemented this", a("theme", href = "https://startbootstrap.com/previews/grayscale/", target="_blank"), "into a R package with golem"),
    p("To find more information to know how to do it, please see this video (comming soon)"),
    card_div(class = "large",
             golem_add_external_resources(),
             graysacle::graysacle_page(
               header = graysacle::graysacle_header(ref_to_go = ns("about")),
               nav = "",#graysacle::graysacle_navbar("Graysacle Style", tabs = c("about" = "About", "projects" = "Projects", "contact" = "Contact")),
               body = tagList(
                 graysacle::graysacle_ressources(),
                 graysacle::graysacle_section_bg(ns("about"),
                                                 fluidRow(
                                                   column(8,
                                                          class = "mx-auto text-center",
                                                          h2("Grayscale", class = "text-white"),
                                                          p("This is a example :D.", class= "text-white")
                                                   )
                                                 ),
                                                 div(
                                                   plotOutput(ns("home")),
                                                   class = "img-fluid"),
                                                 dark = TRUE),
                 graysacle::graysacle_section_bg(ns("projects"),
                                                 graysacle::graysacle_projects(
                                                   br(),
                                                   plotOutput(ns("plot")),
                                                   title = "A plot",
                                                   description = "Iris.... Always iris...",
                                                   first = FALSE),
                                                 graysacle::graysacle_projects(
                                                   tableOutput(ns("table")),
                                                   title = "A table",
                                                   description = "About mtcars... What's next ? Airquality ? ....",
                                                   first = TRUE)
                 ),
                 graysacle::graysacle_section_bg(ns("contact"),
                                                 dark = TRUE,
                                                 br(),
                                                 fluidRow(
                                                   column(6,
                                                          class = "mb-5 mx-auto",
                                                          graysacle::graysacle_card_txt("Mail", "cervan@thinkr.fr")
                                                   ),
                                                   column(6,
                                                          class = "mb-5 mx-auto",
                                                          graysacle::graysacle_card_txt("Website", tags$a('ThinkR', href = "https://thinkr.fr", target= "_blank"))))
                 )
               ),
               footer = graysacle::grayscale_footer(h3("End ! :) "))
             )
    )
  )
}

#' css_another Server Function
#'
#' @noRd 
mod_css_another_server <- function(input, output, session){
  ns <- session$ns
  
  output$plot <- renderPlot({
    
    plot(iris)
  })
  
  output$table <- renderTable(rownames = TRUE, hover = TRUE,{
    mtcars[1:10, 1:5]
  })
  
  
  output$home <- renderPlot({
    shinipsum::random_ggplot()
  })
  
}

## To be copied in the UI
# mod_css_another_ui("css_another_ui_1")

## To be copied in the server
# callModule(mod_css_another_server, "css_another_ui_1")

