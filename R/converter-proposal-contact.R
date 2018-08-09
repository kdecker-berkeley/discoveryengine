#' @export
proposal_contact <- function(proposal) {
    sql <- "select
  prop.proposal_id,
    asst.assignment_id,
    contact.report_id
    from cdw.f_proposal_mv prop
    inner join cdw.f_assignment_mv asst
    on prop.proposal_id = asst.proposal_id
    inner join cdw.f_contact_reports_mv contact
    on (prop.entity_id = contact.contact_entity_id or prop.entity_id = contact.contact_alt_entity_id)
    and contact.contact_date between asst.start_date and nvl(asst.stop_date, sysdate)
    and asst.assignment_entity_id = contact.contact_credit_entity_id"

    converter_builder_custom(
        proposal, custom = sql,
        from = "assignment_id", to = "report_id",
        to_type = "contact_report_id"
    )
}
