#' Find entities who played a sport
#'
#' Make sure you know which sport codes to use. For example, men's and women's
#' basketball have different codes. Take advantage of the synonym search feature
#' if you're not sure (for example: \code{played_sport(?basketball)}). If no
#' sports are entered, widget will find people who played any sport (including
#' intramurals).
#'
#' @param ... Sport codes/synonyms
#'
#' @return A definition of type \code{entity_id}
#'
#' @examples
#' ## anyone who played basketball for Cal
#' played_sport(basketball_men, basketball_women)
#'
#' @export
played_sport <- function(...) {
    sports <- prep_dots(...)
    reroute(played_sport_(sports))
}

played_sport_ <- function(sports) {
    entity_widget("d_bio_sport_mv",
                  parameter = string_param("sport_code", sports))
}

