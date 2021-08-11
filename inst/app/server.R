####
require(magrittr)

# server.r
options(shiny.maxRequestSize= 1000*1024^2)
options(shiny.deprecation.messages=FALSE)

quiet <- function(x) {
  sink(tempfile())
  on.exit(sink())
  invisible(force(x))
}

#quiet(

  shinyServer(function(input,output){
  # this cleans the data a bit
  rfa.packages <- utils::read.csv("https://raw.githubusercontent.com/atkinsjeff/ForestAnalysisInR/main/inst/extdata/bibliometrics/list_of_packages.csv")
  rfa.packages$Applications <- as.factor(rfa.packages$Applications)
  rfa.packages$Link <- paste0("<a href='",rfa.packages$Link,"' target='_blank'>",rfa.packages$Link,"</a>")

  # adding
  # choose columns to display
  tab <- reactive({
    rfa.packages %>%
      dplyr::filter(Applications == input$var1)
  })
  output$table <- DT::renderDataTable({
    tab()}, escape = FALSE, server = TRUE)
})
#)
