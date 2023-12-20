# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
pkgload::load_all()
options("golem.app.prod" = FALSE)
base::get(
  Sys.getenv("RUN_APP_FUNCTION")
)()
