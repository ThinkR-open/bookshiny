# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
options("golem.app.prod" = FALSE)
get(
  Sys.getenv("RUN_APP_FUNCTION", "run_app_css_graysacle")
)()
