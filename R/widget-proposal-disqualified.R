#' @rdname proposal_stage_transition
#' @export
proposal_disqualified <- function(from = NULL, to = NULL) {
    proposal_stage_transition(
        from_stages = "QU",
        to_stages = c('TD', 'DQ'),
        from_date = from, to_date = to)
}
