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
               tags$a(href="./vignettes/fia.pdf", 'Inventory')
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



selectInput(
  'e0', '0. An ordinary select input', choices = state.name,
  selectize = FALSE
)


### TEST TWO
shinyApp(
  ui <- pageWithSidebar(
    rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv"),

    headerPanel("R package for Forestry Analysis"),
    sidebarPanel(
      selectizeInput(
        'e6', '6. Placeholder', choices = rfa.packages$Applications,
        options = list(
          placeholder = 'Please select an option below',
          onInitialize = I('function() { this.setValue(""); }')
        )
      )
      # selectizeInput('var1', 'Select Application', choices = c("choose" = "", levels(table$Applications)),
      #                multiple = TRUE, selected = "Remote Sensing" ),
      # # adding the new div tag to the sidebar
      # tags$div(class="header", checked=NA,
      #          tags$p("Ready to take the Shiny tutorial? If so"),
      #          tags$a(href="shiny.rstudio.com/tutorial", "Click Here!")
      # )
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

    # choose columns to display
    tab <- reactive({
      rfa.packages %>%
        dplyr::filter(Applications == input$var1)
    })
    output$table <- DT::renderDataTable({
      tab()}, escape = FALSE, server = TRUE)
  })
)



############
library(shiny)
library(DT)
shinyApp(
  ui = fluidPage(
    varSelectInput("variables", "Variable:", mtcars, multiple = TRUE),
    tableOutput("data")
  ),
  server = function(input, output) {
    output$data <- renderTable({
      if (length(input$variables) == 0) return(mtcars)
      mtcars %>% dplyr::select(!!!input$variables)
    }, rownames = TRUE)
  }
)
