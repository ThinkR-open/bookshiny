#' css_bs4dash UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom  shinipsum random_ggplot
mod_css_bs4dash_ui <- function(id){
  ns <- NS(id)
  tagList(
    bs4Dash::bs4DashPage( 
      navbar = bs4Dash::bs4DashNavbar(compact = TRUE, rightUi = tagList(back_home(ns("home-page")))),
      sidebar = bs4Dash::bs4DashSidebar(
        bs4Dash::bs4SidebarMenu(
          bs4Dash::bs4SidebarHeader("Example of bs4Dash package"),
          bs4Dash::bs4SidebarUserPanel(
            img = "https://rinterface.com/inst/images/bs4Dash.svg",
            text = p("Develops beautiful",p("Shinyapps"))
          ),
          bs4Dash::bs4SidebarMenu(
            bs4Dash::bs4SidebarHeader("Menu"),
            bs4Dash::bs4SidebarMenuItem(
              "Home",
              tabName = ns("home"),
              icon = "box-open"
            ),
            bs4Dash::bs4SidebarMenuItem(
              "Graph",
              tabName = ns("graph"),
              icon = "chart-area"
            ),
            bs4Dash::bs4SidebarMenuItem(
              "Table",
              tabName = ns("table"),
              icon = "table"
            )
          )
        )
      ),
      body = bs4Dash::bs4DashBody(
        bs4Dash::bs4TabItems(
          bs4Dash::bs4TabItem(
            tabName = ns("home"),
            h2("{bs4Dash package}"),
            bs4Dash::bs4Card(width = 12,
                             title = "Welcome Card", 
                             status = "warning", 
                             p("Here is an example of using this package to design your application")
            ),
            bs4Dash::bs4Card(width = 12,
                             title = "Thanks", 
                             status = "primary", 
                             p("Thanks to David Granjon for this package."),
                             p("You can find more information about it ", a("here", target = "_blank", href = "https://rinterface.github.io/bs4Dash/"))
            )
          ),
          bs4Dash::bs4TabItem(
            tabName = ns("graph"),
            fluidRow(
              column(6,
                     bs4Dash::bs4Card(width = 12,
                                      title = "First graph", 
                                      plotOutput(ns("graph1"))
                     )
              ),
              column(6,
                     bs4Dash::bs4Card(width = 12,
                                      title = "Second graph", 
                                      plotOutput(ns("graph2"))
                     )
              )
            )
          ),
          bs4Dash::bs4TabItem(
            tabName = ns("table"),
            fluidRow(
              column(6,
                     bs4Dash::bs4Card(width = 12,
                                      title = "First table", 
                                      DT::DTOutput(ns("table1"))
                     )
              ),
              column(6,
                     bs4Dash::bs4Card(width = 12,
                                      title = "Second table", 
                                      tableOutput(ns("table2"))
                     )
              )
            )
          )
        )
      )
    )
  )
}

#' css_bs4dash Server Function
#'
#' @noRd 
mod_css_bs4dash_server <- function(input, output, session){
  ns <- session$ns
  
  output$graph1 <- renderPlot({
    shinipsum::random_ggplot("boxplot")
  })
  
  output$graph2 <- renderPlot({
    shinipsum::random_ggplot("line")
  })
  
  
  output$table1 <- DT::renderDT({
    shinipsum::random_DT(nrow = 10, ncol = 5)
  })
  
  output$table2 <- renderTable({
    shinipsum::random_table(nrow = 10, ncol = 5)
  })
}

## To be copied in the UI
# mod_css_bs4dash_ui("css_bs4dash_ui_1")

## To be copied in the server
# callModule(mod_css_bs4dash_server, "css_bs4dash_ui_1")

