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
