#' @export
lives_in_msa <- function(..., type = "H") {
    msa <- prep_dots(...)
    lives_in_msa_(msa, type)
}

lives_in_msa_ <- function(msa, type = "H") {
    address_widget("geo_metro_area_code", msa, type)
}
