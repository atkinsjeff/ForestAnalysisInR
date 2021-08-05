##### dependencies
library(shiny)
library(DT)
library(tinyverse)


#### functionalize
rfaApp <- function(...){
shinyApp(
  ui <- pageWithSidebar(
    #rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv"),

    headerPanel("R package for Forestry Analysis"),
    sidebarPanel(
      selectizeInput('var1', 'Select Application', choices = c("choose" = "", levels(rfa.packages$Applications)),
                     multiple = TRUE, selected = "Remote Sensing" )),
    mainPanel(
      DT::dataTableOutput("table")
    )
  ),

  server <- shinyServer(function(input,output){
    # this cleans the data a bit
    rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv")
    rfa.packages$Applications <- as.factor(rfa.packages$Applications)
    rfa.packages$Link <- paste0("<a href='",rfa.packages$Link,"' target='_blank'>",rfa.packages$Link,"</a>")

    # choose columns to display
    tab <- reactive({
      rfa.packages %>%
        dplyr::filter(Applications == input$var1)
    })
    output$table <- DT::renderDataTable({
      tab()}, escape = FALSE, server = TRUE)
  })
)
}
