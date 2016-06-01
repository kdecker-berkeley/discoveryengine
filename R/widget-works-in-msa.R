works_in_msa <- function(..., type = "B") {
    msas <- prep_dots(...)
    works_in_msa_(msas, type)
}

works_in_msa_ <- function(msas, type = "B") {
    address_widget("geo_metro_area_code", msas, type = type)
}


