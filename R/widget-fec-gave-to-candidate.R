#' @rdname fec
#' @export
fec_gave_to_candidate <- function(..., at_least = .01, from = NULL, to = NULL) {
    cands <- prep_dots(...)
    reroute(fec_gave_to_candidate_(cands, at_least = at_least,
                                   from = from , to = to))
}

fec_gave_to_candidate_ <- function(cands, at_least = .01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    committees <- widget_builder(
        table = "fec_ccl",
        id_field = "cmte_id",
        id_type = "cmte_id",
        parameter = string_param("cand_id", cands),
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
