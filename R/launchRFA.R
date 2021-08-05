#'Launch ForestAnalysisInR App
#
#'@description This function launch the treetop application.
#'
#'@usage launchApp(...)
#'
#'@param ... additional parameters from the \code{\link[shiny:runApp]{runApp}} function in the \emph{shiny} package.
#'@return This function does not return.
#'@details The ForestryAnalysisInR app doesn't really work actually. Big sad
#'@references

#'
#'@examples
#'\dontrun{
#'
#'# Launch treetop application
#'ForestryAnalysisInR::launchRFA(launch.browser = TRUE)
#'
#'}
#'@export
#'@importFrom shiny runApp
#'@importFrom dplyr filter
#'@importFrom DT dataTableOutput
#'@importFrom DT renderDataTable
#'@importFrom utils read.csv
#'@importFrom magrittr %>%

launchRFA<-function(...){
  #appDir <- file.path(path.package("ForestAnalysisInR", quiet=TRUE),"app")
  appDir <- file.path("C:/R/ForestAnalysisInR/inst/app")
  shiny::runApp(appDir)
}
