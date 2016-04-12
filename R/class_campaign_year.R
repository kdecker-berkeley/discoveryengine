class_campaign_year <- function(...) {
    param <- prep_integer_param(...)
    param <- list(substitute(class_campaign_year %in% param))
    people_(param)
}

class_campaign_year_ <- function(...) {
    class_campaign_year(...)
}
