#' Connect to the good database
#'
#' @param dev TRUE or FALSE
#'
#' @return connect
connect_db <- function(dev = golem::app_dev()){
  if(dev){
    db <- system.file("app/database.sqlite", package = "bookshiny")
    ask <- DBI::dbCanConnect(RSQLite::SQLite(), db)
    if(ask){
      con <- dbConnect(RSQLite::SQLite(), db)
    }else{
      con <- NULL
    }
  }else{
    config <- bookshiny::get_golem_config(config = "production", value = "database")
    ask <- DBI::dbCanConnect(RPostgres::Postgres(),
                             dbname = config$dbname, 
                             host = config$host,
                             port = config$port, 
                             user = config$user,
                             password = config$password)
    if(ask){
      con <- DBI::dbConnect(RPostgres::Postgres(),
                            dbname = config$dbname, 
                            host = config$host,
                            port = config$port, 
                            user = config$user,
                            password = config$password)
    }else{
      con <- NULL
    }
  }
  list(con = con, connect = ask)
}

#' Title
#'
#' @param x vector
#'
null_to_na <- function(x) {
  if(is.null(x)){
    NA 
  }else{
    x
  }
}

#' Modal database !
#'
#' @param session session
modal_confirm <- function(session = getDefaultReactiveDomain()){
  ns <- session$ns
  modalDialog(title = "", 
              tagList(
                p("Send answers to the database ?")
              ),
              footer = 
                tagList(
                  column(6, 
                         actionButton(ns('ok'), "Send !") %>%
                           htmltools::tagAppendAttributes(
                             onclick = sprintf("$( '#%s' ).slideToggle( 'fast' );", ns("form"))
                           )
                  ),
                  column(6, 
                         actionButton(ns('no'), "Nope..."))
                )
  )
}

#' refresh table
#'
#' @param id id input
#' @param id_refresh_msg id refrech message
#' @param session session
refresh <- function(id, id_refresh_msg, session = getDefaultReactiveDomain()){
  tagList(
    div(
      icon("sync") %>%
        htmltools::tagAppendAttributes(
          onclick = paste0(
            "Shiny.setInputValue('",
            id,
            "', value = Math.random())"),
          style= "cursor: pointer;")
    ),
    div(
      id= id_refresh_msg,
      class = 'card-book succes',
      p("Done !")
    )
  )
}

#' plot for database
#'
#' @param data data
#' @param var var like character
plot_db <- function(data, var){
  ggplot(data) + 
    aes(.data[[var]]) +
    geom_bar(fill = "#0e7b90") +
    theme_light()
}

#' validate need together
#'
#' @param ... condition
#' @param msg msg
not_validate <- function(...,msg){
  validate(
    need(..., message = msg)
  )
}