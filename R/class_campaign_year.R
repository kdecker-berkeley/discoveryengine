#' @export
class_campaign_year <- function(...) {
    param <- prep_integer_param(...)
    if (length(param) > 0)
        param <- list(substitute(class_campaign_year %in% param))
    else param <- list(substitute(class_campaign_year %is not% null))
    people_(param)
}

class_campaign_year_ <- function(...) {
    class_campaign_year(...)
}
