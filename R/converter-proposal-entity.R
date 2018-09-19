#' Retrieve the relevant entities from a list of proposals
#'
#' This widget allows you to take an existing definition of type
#' \code{assignment_id} (from the proposal widgets) and convert it to a
#' definition of type \code{entity_id},
#' by finding the entities connected to the proposals (via the prospect records).
#'
#' @param proposals A definition of type \code{assignment_id}, which are built
#' using proposal widgets
#' @param include_inactive Should inactive proposals/assignments be considered?
#' Defaults to \code{TRUE}
#'
#' @export
proposal_entity <- function(proposals, include_inactive = TRUE) {
    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"


    conversion_sql <- "
select
  prop.proposal_id,
  prop.entity_id,
  nvl(asst.assignment_id, 0) as assignment_id,
  prop.active_ind as proposal_active,
  nvl(asst.active_ind, prop.active_ind) as assignment_active
from      cdw.f_proposal_mv prop
left join cdw.f_assignment_mv asst
       on prop.proposal_id = asst.proposal_id"


    converter_builder_custom(
        proposals,
        custom = conversion_sql,
        from = "assignment_id",
        from_type = "assignment_id",
        to = "entity_id", to_type = "entity_id",
        switches = list(
            string_switch("proposal_active", active_ind),
            string_switch("assignment_active", active_ind))
    )
}
