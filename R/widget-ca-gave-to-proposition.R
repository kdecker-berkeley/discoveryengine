#' @export
ca_gave_to_proposition <- function(..., at_least = .01, from = NULL, to = NULL,
                                   support = TRUE) {
    props <- prep_dots(...)
    reroute(ca_gave_to_proposition_(props, at_least = at_least,
                                    from = from , to = to, support = support))
}

ca_gave_to_proposition_ <- function(props, at_least = .01,
                                    from = NULL, to = NULL,
                                    support = TRUE) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    filings <- widget_builder(
        table = "ca_campaign_proposition",
        id_field = "filing_id",
        id_type = "ca_filing_id",
        parameter = string_param("proposition_id", props),
        schema = "rdata"
    )

    converter_builder(
        filings,
        table = "ca_campaign",
        from = "filing_id", from_type = "ca_filing_id",
        to = "entity_id", to_type = "entity_id",
        switches = list(daterange("rcpt_date", from = from, to = to)),
        aggregate_switches = sum_switch("amount", at_least),
        schema = "rdata"
    )
}
