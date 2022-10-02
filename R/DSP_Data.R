#' NanoString GeoMx Digital Spatial Profiler (DSP) data
#'
#' Data from Delorey et al. (GSE163529), which was used to investigate proteomics alternations due to SARS-CoV-2 infection.
#' The data contains 330 ROIs, that are obtained from multiple locations of multiple patients. See the meta data Meta.DSP for more details.
#'
#' @docType data
#'
#' @usage data(COVID.19.DSP)
#'
#' @format An object of class \code{"list"}.
#'
#' @keywords datasets
#'
#' @references Delorey et al. (2021) Nature 2021 Jul;595(7865):107-113.
#' (\href{https://www.ncbi.nlm.nih.gov/pubmed/33915569}{PubMed})
#'
#' @source \href{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE163529}{GEO}
#'
#' @examples
#' data(COVID.19.DSP)
#'
#' # raw DSP expression matrix, as an object of data.frame:
#' expression.raw <- COVID.19.DSP$Expr.raw.DSP
#'
#' # meta info of the 330 ROIs, as an object of data.frame:
#' info.ROI <- COVID.19.DSP$Meta.DSP
"COVID.19.DSP"
