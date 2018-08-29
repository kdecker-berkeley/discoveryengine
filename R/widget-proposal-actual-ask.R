#' Find proposals with given ask dates/amounts
#'
#' @param at_least only look for asks of at least this much
#' @param from daterange in YYYYMMDD format
#' @param to daterange in YYYYMMDD format
#'
#' @export
proposal_actual_ask <- function(at_least = 0, from = NULL, to = NULL) {
    widget_builder_custom(
        custom = proposal_query(),
        id_field = "assignment_id",
        id_type = "assignment_id",
        switches = list(
            daterange("actual_ask_date", from , to),
            at_least_switch("actual_ask_amt", at_least),
            string_switch("assigned_at_ask", "Y")
        )
    )
}
