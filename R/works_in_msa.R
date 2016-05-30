works_in_msa <- function(..., type = "B", env = parent.frame()) {
    msas <- pryr::dots(...)
    works_in_msa_(msas, type, env)
}

works_in_msa_ <- function(msas, type = "B", env = parent.frame()) {
    address_widget("geo_metro_area_code", msas,
                   type = type, env = env)
}


