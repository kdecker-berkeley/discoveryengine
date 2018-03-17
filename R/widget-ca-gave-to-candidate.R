#' California campaign finance disclosure widgets
#'
#' Find entities who have disclosed political contributions in California
#' statewide election campaigns. \code{ca_gave_to_candidate} only allows you to
#' search for donors to candidates in statewide races (excluding candidates in local
#' races), while \code{ca_gave_to_proposition} allows you to search for donors to
#' ballot initatives. In order to search for all types of giving in California
#' elections (including local races such as superior court judge or city council),
#' use \code{ca_gave}
#'
#' @param ... Candidate ID(s) or ballot proposition IDs (see examples)
#' @param at_least Minimum of aggregate contributions
#' @param from begin and end dates (contributed between those dates). Enter as integer of the form YYYYMMDD
#' @param to begin and end dates (contributed between those dates). Enter as integer of the form YYYYMMDD
#' @param support TRUE/FALSE, whether to look for supporters (TRUE) or those opposed (FALSE) to the ballot initiative. Defaults to both (support and oppose)
#'
#' @details Since this is based on a probabilistic match score, there will be some
#' false positive matches. If perfect accuracy is necessary, be sure to manually
#' review the results. Use the built-in lookup features to identify the correct
#' IDs. For instance, \code{ca_gave_to_proposition(?bag)} will help find the
#' correct ID for Prop 65, the charge on carry-out bags.
#'
#' @examples
#' ## example: find donors to Kamala Harris's Attorney General campaign
#' ## first find her candidate ID
#' ca_gave_to_candidate(?kamala)
#'
#' ## now use the ID:
#' ca_gave_to_candidate(CA770144)
#'
#' ## look for donors who opposed marijuana decriminialization
#' ca_gave_to_proposition(?marijuana)
#'
#' ## and use the resulting ID:
#' ## looking only for supporters:
#' ca_gave_to_proposition(BL20150064, support = TRUE)
#'
#' @name ca_campaign
#'
#' @export
ca_gave_to_candidate <- function(..., at_least = .01, from = NULL, to = NULL) {
    cands <- prep_dots(...)
    reroute(ca_gave_to_candidate_(cands, at_least = at_least,
                                   from = from , to = to))
}

ca_gave_to_candidate_ <- function(cands, at_least = .01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    committees <- widget_builder(
        table = "ca_campaign_candidate",
        id_field = "filing_id",
        id_type = "ca_filing_id",
        parameter = string_param("candidate_id", cands),
        schema = "rdata"
    )

    converter_builder(
        committees,
        table = "ca_campaign",
        from = "filing_id", from_type = "ca_filing_id",
        to = "entity_id", to_type = "entity_id",
        switches = list(daterange("rcpt_date", from = from, to = to)),
        aggregate_switches = sum_switch("amount", at_least),
        schema = "rdata"
    )
}
