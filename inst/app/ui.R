# Libraries
#options(rgl.useNULL=TRUE)
#options(shiny.deprecation.messages=FALSE)

################################################################################

appDir <- file.path(file.path("C:/R/ForestAnalysisInR/inst/app"))


###
shinyUI(pageWithSidebar(
  #rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv"),

  headerPanel("R package for Forestry Analysis"),
  sidebarPanel(
    selectizeInput('var1', 'Select Application', choices = c("choose" = "", c("Inventory/Mensuration", "Community Analysis", "Dendrochronology",      "Modelling/Simulation",
                                                                              "Phenology","Remote Sensing")), multiple = FALSE, selected = "Remote Sensing" ),
    # # adding the new div tag to the sidebar
    tags$div(class="header", checked=NA,
             tags$p("Tutorials"),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/vignettes/fia.pdf", 'Inventory,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/vignettes/dendro.pdf", 'Dendrochronology,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/vignettes/modelling.pdf", 'Forest Modelling')

    )
  ),
  mainPanel(
    DT::dataTableOutput("table")
  )
)
)
