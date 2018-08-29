#' @rdname proposal_stage_transition
#' @export
proposal_qualified <- function(from = NULL, to = NULL) {
    proposal_stage_transition(
        from_stages = "QU",
        to_stages = c('CU', 'SP', 'PD', 'GS', 'DS'),
        from_date = from, to_date = to)
}

