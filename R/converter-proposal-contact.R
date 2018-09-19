#' Find contact reports related to selected proposals
#'
#' Looks for contact reports made with an assigned prospect, by the assigned
#' officer, during the time that the proposal was active. Some gift officers
#' reach out to qualification prospects before initating a proposal/assignment.
#' If you need to capture such contact reports, use \code{buffer} to
#' look back before the start of the proposal.
#'
#' @param proposal A discoveryengine definition of type \code{proposal_id}
#' @param buffer Number of days before the start of the proposal to look (see details)
#'
#' @return A definition of type \code{contact_report_id}
#'
#' @examples
#' ## find engineering qualification contacts during FY18
#' qualified = proposal_qualified(from = 20170701, to = 20180630) %and%
#'    proposal_office(engineering)
#' qual_contact = proposal_contact(qualified, buffer = 15)
#'
#' @export
proposal_contact <- function(proposal, buffer = 0) {
    if (!(assertthat::is.count(buffer) || buffer == 0))
        stop("`buffer` must be an integer")
    tmpl <- getcdw::parameterize_template("select
  prop.proposal_id,
    asst.assignment_id,
    contact.report_id
    from cdw.f_proposal_mv prop
    inner join cdw.f_assignment_mv asst
    on prop.proposal_id = asst.proposal_id
    inner join cdw.f_contact_reports_mv contact
    on (prop.entity_id = contact.contact_entity_id or prop.entity_id = contact.contact_alt_entity_id)
    and contact.contact_date between asst.start_date - ##buffer## and nvl(asst.stop_date, sysdate)
    and asst.assignment_entity_id = contact.contact_credit_entity_id")

    sql <- tmpl(buffer = buffer)

    converter_builder_custom(
        proposal, custom = sql,
        from = "assignment_id", to = "report_id",
        to_type = "contact_report_id"
    )
}
