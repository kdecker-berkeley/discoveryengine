#' @export
proposal_entity <- function(proposals, include_inactive = FALSE) {
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
