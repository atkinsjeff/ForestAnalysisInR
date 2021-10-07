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
    selectizeInput('var1', 'Select Application', choices = c("choose" = "", c("Community Analysis", "Dendrochronology", "Inventory/Mensuration",  "Modelling/Simulation",
                                                                              "Phenology","Remote Sensing")), multiple = FALSE, selected = "Remote Sensing" ),
    # # adding the new div tag to the sidebar
    tags$div(class="header", checked=NA,
             tags$p("Tutorials"),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/extdata/doc/forest_inventory_and_analysis.pdf", 'Inventory,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/extdata/doc/dendrochronology.pdf", 'Dendrochronology,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/extdata/doc/forest_modelling.pdf", 'Forest Modelling,'),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/extdata/doc/remote_sensing.pdf", "Remote Sensing,"),
             tags$a(href="https://github.com/atkinsjeff/ForestAnalysisInR/blob/main/inst/extdata/doc/phenology.pdf", "Phenology")

    ),
    br(),
    HTML("<p>To submit an R package to this database, please use our
         <a href='https://forms.gle/4E89hAMUF9vzcKbR6'>ForestAnalysis in R Google Form</a></p>"),
  ),
  mainPanel(
    DT::dataTableOutput("table")
    )
  )
)
