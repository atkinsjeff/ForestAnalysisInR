##### dependencies
library(shiny)
library(DT)
library(tidyverse)


#### functionalize
rfaApp <- function(...){
  #rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv")

shinyApp(
  ui <- pageWithSidebar(
    #rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv"),

    headerPanel("R package for Forestry Analysis"),
    sidebarPanel(
      selectizeInput('var1', 'Select Application', choices = c("choose" = "", c("Inventory/Mensuration", "Community Analysis", "Dendrochronology",      "Modelling/Simulation",
                                                                                "Phenology","Remote Sensing")), multiple = FALSE, selected = "Remote Sensing" ),
      # # adding the new div tag to the sidebar
      tags$div(class="header", checked=NA,
               tags$p("Tutorials"),
               tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/vignettes/fia.pdf", 'Inventory')
        )
      ),
    mainPanel(
      DT::dataTableOutput("table")
    )
  ),

  server <- shinyServer(function(input,output){
    # this cleans the data a bit
    rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv")
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
)
}


