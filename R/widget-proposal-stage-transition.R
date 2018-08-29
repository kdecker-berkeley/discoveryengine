#' Find proposals that had the given stage transition during a given time period
#'
#' @param from_stages character vector of one or more stages
#' @param to_stages character vector of one or more stages
#' @param from_date daterange in YYYYMMDD format
#' @param to_date daterange in YYYYMMDD format
#' @param from daterange in YYYYMMDD format
#' @param to daterange in YYYYMMDD format
#'
#' Note that \code{proposal_qualified} just looks for transitions between
#' \code{QU} and any of \code{(CU, SP, PD, GS, DS)}. Similarly,
#' \code{proposal_disqualified} looks for transitions from
#' \code{QU} to \code{(TD, DQ)}.
#'
#' @export
proposal_stage_transition <- function(from_stages = NULL, to_stages = NULL,
                                      from_date = NULL, to_date = NULL) {
    dates <- daterange("stage_transition_date", from = from_date, to = to_date)
    from_stage_switch <- string_switch("stage_from", from_stages)
    to_stage_switch <- string_switch("stage_to", to_stages)

    widget_builder_custom(
        custom = proposal_query(),
        id_field = "assignment_id",
        id_type = "assignment_id",
        switches = list(dates, from_stage_switch, to_stage_switch,
                        string_switch("assigned_at_transition", "Y"))
    )
}

