#' @rdname ca_campaign
#' @export
ca_gave <- function(at_least = .01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    widget_builder(
        table = "ca_campaign",
        id_field = "entity_id",
        id_type = "entity_id",
        switches = list(daterange("rcpt_date", from = from, to = to)),
        aggregate_switches = sum_switch("amount", at_least),
        schema = "rdata"
    )
}
