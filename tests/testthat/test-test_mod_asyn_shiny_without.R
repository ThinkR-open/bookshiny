context("Testing mod_asyn_shiny_witout")

server <- function(id) {
  moduleServer(id, mod_asyn_shiny_without_server)
}

tryCatch({
  testServer(server, {
      session$setInputs(generate = 1)
      Sys.sleep(6)
      expect_is(local$plot, class = "ggplot")

      # is everything fine ?
      output$graph
  })
}, error = function(){
  stop()
})