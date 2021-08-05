#' Forest Inventory Data
#'
#' @details Import forestry package list
#'
#' @note List updated 2021-08-03
#' @return A `data.frame` or `tibble`. Call \code{\link{fd_metadata}} for field metadata.
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
  rfa.packages <- utils::read.csv("./inst/extdata/bibliometrics/list_of_packages.csv", stringsAsFactors = FALSE)
  return(rfa.packages)
}
