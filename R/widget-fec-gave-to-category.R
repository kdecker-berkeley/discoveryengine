#' @rdname fec
#' @export
fec_gave_to_category <- function(..., at_least = .01, from = NULL, to = NULL) {
    types <- prep_dots(...)
    reroute(fec_gave_to_category_(types, at_least = at_least,
                                  from = from , to = to))
}

fec_gave_to_category_ <- function(types, at_least = .01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    message("Committee categorization comes from the Center for Responsive Politics (www.OpenSecrets.org)")

    committees <- widget_builder(
        table = "fec_cmte_category",
        id_field = "cmte_id",
        id_type = "cmte_id",
        parameter = string_param("cmte_code", types),
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
