pkgload::load_all()

# Use packrat instead of renv to simplify deployment
options(rsconnect.packrat = TRUE)

run_app_prefix <- function(name)  {
  paste0("run_app_", name)
}

# Construct app list to be deployed
# vector names = app name
# vector values = name of the dedicated run_app_* function
app_list <- list(
  c(
    "databasedemo" =  run_app_prefix("database")
  ),
  c(
    "grayscale" = run_app_prefix("css_graysacle")
  ),
  # c(
  #   "bs4dashdemo" =  run_app_prefix("bs4dash")
  # ),
  c(
    "with_p_f" = run_app_prefix("with_p_f")
  ),
  c(
    "without_p_f" =  run_app_prefix("without_p_f")
  )
)


for (app in app_list) {
  withr::with_envvar(
    c(
      "RUN_APP_FUNCTION" = unname(app)
    ),
    {
      message(
        sprintf(
          "Deploying app: %s based on function %s",
          names(app),
          Sys.getenv("RUN_APP_FUNCTION")
        )
      )
      lozen::deploy_connect_shiny(
        connect_url = Sys.getenv("CONNECT_URL"),
        connect_user = Sys.getenv("CONNECT_USER"),
        connect_api_token = Sys.getenv("CONNECT_TOKEN"),
        app_name = names(app),
        appTitle = names(app),
        forceUpdate = TRUE,
        envVars = "RUN_APP_FUNCTION"
      )
    }
  )
}


