#' Find proposals with given purpose programs
#'
#' @param ... program code(s)
#' @param target purpose target ask amount (at least this much)
#' @param actual purpose actual ask amount (at least this much)
#' @param commit purpose commit amount (at least this much)
#'
#' @export
proposal_purpose <- function(..., target = 0, actual = 0, commit = 0) {
    reroute(proposal_purpose_(prep_dots(...),
                              target = target,
                              actual = actual,
                              commit = commit))
}

proposal_purpose_ <- function(purposes, target = 0, actual = 0, commit = 0) {
    props <- widget_builder(
        "f_proposal_purpose_mv",
        id_field = "proposal_id",
        id_type = "proposal_id",
        parameter = string_param("program_code", purposes),
        switches = list(
            at_least_switch("purpose_target_amt", target),
            at_least_switch("purpose_actual_amt", actual),
            at_least_switch("purpose_commit_td_amt", commit)
        )
    )

    converter_builder(
        props, table = "f_assignment_mv",
        from = "proposal_id", to = "assignment_id"
    )
}
