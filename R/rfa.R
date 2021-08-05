#' Forest Inventory Data
#'
#' @details Import forestry package list
#'
#' @note List updated 2021-08-03
#' @return A `data.frame`
#' @format
#'  \code{Package}Package name
#'  \code{Applications}Application (e.g. remote sensing, mensuration, inventory)
#'  \code{Description}CRAN/GitHub package description from author(S)
#'  \code{Link}URL to access
#' @export
#' @examples
#' rfa()

rfa <- function() {

  # import data
  rfa.packages <- utils::read.csv("https://raw.githubusercontent.com/atkinsjeff/ForestAnalysisInR/main/inst/extdata/bibliometrics/list_of_packages.csv")
  return(rfa.packages)
}
