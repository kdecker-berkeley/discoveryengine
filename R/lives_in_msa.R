lives_in_msa <- function(..., type = "H", env = parent.frame()) {
    msa <- pryr::dots(...)
    lives_in_msa_(msa, type, env)
}

lives_in_msa_ <- function(msa, type = "H", env = parent.frame()) {
    address_widget("geo_metro_area_code", msa, type, env)
}
