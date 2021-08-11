# Libraries
#options(rgl.useNULL=TRUE)
#options(shiny.deprecation.messages=FALSE)

################################################################################

appDir <- file.path(path.package("ForestAnalysisInR", quiet=TRUE),"app")


###
shinyUI(pageWithSidebar(
  #rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv"),

  headerPanel("R packages for Forestry Analysis"),
  sidebarPanel(
    selectizeInput('var1', 'Select Application', choices = c("choose" = "", c("Inventory/Mensuration", "Community Analysis", "Dendrochronology",      "Modelling/Simulation",
                                                                              "Phenology","Remote Sensing")), multiple = FALSE, selected = "Remote Sensing" ),
    # # adding the new div tag to the sidebar
    tags$div(class="header", checked=NA,
             tags$p("Tutorials"),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/doc/fia.pdf", 'Inventory,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/doc/dendro.pdf", 'Dendrochronology,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/doc/modelling.pdf", 'Forest Modelling')

    )
  ),
  mainPanel(
    DT::dataTableOutput("table")
  )
)
)
