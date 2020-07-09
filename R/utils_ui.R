#' Card 
#'
#' @param ... HTML tags
#' @param class class
#'
card_div <- function(..., class=NULL){
  if(is.null(class)){
    class <- "card-book"
  }else{
    class <- paste("card-book", class)
  }
  div(class=class, ...)
}


#' Card hover
#'
#' @param ... HTML tags
#' @param class class
#'
card_hover_div <- function(class = NULL, ...){
  if(is.null(class)){
    class <- "card-book-hover"
  }else{
    class <- paste("card-book-hover", class)
  }
  div(class=class, ...)
}

#' Busy
#'
#' @param id id
shiny_busy <- function(id){
  tagList(
    tags$div(class="alert-book", 
             id = id,
             tags$div(class = "busy card-book",
                      p("Your application is blocked by the generation of the graphic"))
    )
  )
}

#' Busy not blocking
#'
#' @param id id
shiny_busy_not_blocking <- function(id){
  tagList(
    tags$div(class = "busy-not-blocking card-book",
             id = id,
             p("The graphic is calculated but you can still use the application."))
  )
}

#' Card 
#'
#' @param ... HTML tags
#' @param class class
#'
card_div_shadow <- function(..., class=NULL){
  if(is.null(class)){
    class <- "card-shadow"
  }else{
    class <- paste("card-shadow", class)
  }
  div(class=class, ...)
}

#' Code
#' @param ... HTML tags
pre_code <- function(...){
  pre(code(...), .noWS = c("before", "after", "outside", "after-begin","before-end"))
}

#' Toasts
#'
toasts <- function() {
  tagList(
    div(id = "succes", 
        class = "succes card-book",
        p("Successful connection!")
    ),
    div(id = "error",
        class = "error card-book",
        p("Connection Error!")
    )
  )
} 

#' Heart
#' 
#' @param id id
heart <- function(id){
  htmltools::HTML(
    sprintf('<svg id="%s" class="heart" viewBox="0 0 32 29.6">
      <path d="M23.6,0c-3.4,0-6.3,2.7-7.6,5.6C14.7,2.7,11.8,0,8.4,0C3.8,0,0,3.8,0,8.4c0,9.4,9.5,11.9,16,21.2 c6.1-9.3,16-12.1,16-21.2C32,3.8,28.2,0,23.6,0z"/>
      </svg> ', 
            id
    )
  )}

#' card img
#' 
#' @param img img 
#' @param ... list of tags
card_img <- function(img = "img/golem.png", ...){
  card_hover_div(
    img(src = app_sys(img), class = "img-card"),
    tagList(...)
  )
}


#'Carrousel in r
#'
#' @param ... div_carousel functions
#' @param number_div number of future div_carousel
#' @param width width
#' @param height height
carousel <- function(..., number_div=3, width="100%", height="100%"){
  tagList(
    div(id = "carouselExampleIndicators",
        class = "carousel slide",
        'data-ride'="carousel",
        style = paste0("width:", width, ";", "height:", height),
        tags$ol(class="carousel-indicators",
                tagList(
                  tags$li('data-target'="#carouselExampleIndicators",
                          'data-slide-to'=0, class='active'),
                  lapply(seq_len(number_div-1), function(x){
                    tags$li('data-target'="#carouselExampleIndicators",
                            'data-slide-to'=x)
                  })
                )
        ),
        div(
          class="carousel-inner",
          role="listbox",
          style="height:100%",
          ...
        ),
        a(class="left carousel-control",href="#carouselExampleIndicators",role="button",'data-slide'="prev",
          span(class="glyphicon glyphicon-chevron-left", 'aria-hidden'="true"),
          span(class="sr-only","Previous")
        ),
        a(class="right carousel-control",href="#carouselExampleIndicators",role="button",'data-slide'="next",
          span(class="glyphicon glyphicon-chevron-right", 'aria-hidden'="true"),
          span(class="sr-only","Next")
        )
    ),
    # includeScript(path = "https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"),
    tags$script("$('.carousel').carousel({interval: 3000})")
  )
}


#' div_carousel
#'
#' @param ... tagList
#' @param active if TRUE, show up in the carousel
#'
div_carousel <- function(..., active=FALSE){
  if(active){
    class <- "item active"
  }else{
    class <- "item"
  }
  div(class=class,
      div( style="text-align:center;",
           ...)
  )
}


#' a like bttn
#'
#' @param text text
#' @param href href
#'
a_bttn <- function(text, href){
  a(text, href = href, class="btn btn-info", target="_blank")
}

#' Back Home
#'
#' @param id id 
#'
#' @importFrom glue glue
back_home <- function(id){
  div(class="back-home size-bttn-home",
      a(id = id,  icon("home", class="fa-2x"), href = "http://connect.thinkr.fr/bookshiny")#,
      # tags$script(glue("$('.back-home').mouseenter(function(){$('#<id>').toggle('slow')}).mouseleave(function(){$('#<id>').toggle('slow')})", .open = "<", .close = ">"))
      )
}
