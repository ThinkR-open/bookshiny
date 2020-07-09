library(magrittr)
golem::document_and_reload()
pkgload::load_all()

tmp <- tempdir()
fs::dir_copy(path = ".", new_path = tmp, overwrite = TRUE)

manipule_app <- function(x){
  file <- readLines("app.R")
  file <- file[1:6]
  file[7] <- x
  file[8] <-""
  writeLines(file, con = "app.R")
}
run_app_fct <- ls( "package:bookshiny", pattern = "run_app" ) %>%
  paste0("bookshiny::", ., "()") 
# names <- run_app_fct %>%
#   gsub("bookshiny::run_", "", .) %>%
#   gsub("\\(\\)", "", .)

vecteur_name <- c("bookshiny", "bs4dash", "graysacle", "database_final", "shinipsum_book", "with_p_f", "without_p_f")

withr::with_dir(tmp,{
  purrr::map2(run_app_fct[2:7], .y = vecteur_name[2:7], ~{
    
    manipule_app(.x)
    appname <- .y
    rsconnect::deployApp(appDir = ".", 
                         appName = appname,
                         appTitle = appname,
                         lint = FALSE,
                         account = Sys.getenv("CONNECT_NAME"),
                         server  = Sys.getenv("CONNECT_SERVER"),
                         forceUpdate = TRUE)
  })
})

message("")
