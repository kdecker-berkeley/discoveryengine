#' @rdname fec
#' @export
fec_gave_to_party <- function(..., at_least = .01, from = NULL, to = NULL) {
    parties <- prep_dots(...)
    reroute(fec_gave_to_party_(parties, at_least = at_least,
                               from = from , to = to))
}

fec_gave_to_party_ <- function(parties, at_least = .01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    committees <- widget_builder(
        table = "fec_committees",
        id_field = "cmte_id",
        id_type = "cmte_id",
        parameter = string_param("cmte_pty_affiliation", parties),
        schema = "rdata"
    )

    converter_builder(
        committees,
        table = "fec",
        from = "cmte_id", from_type = "cmte_id",
        to = "entity_id", to_type = "entity_id",
        switches = list(daterange("transaction_dt", from = from, to = to)),
        aggregate_switches = sum_switch("transaction_amt", at_least),
        schema = "rdata"
    )
}
