#' @export
gave_to_fund <- function(savedlist, at_least = .01, from = NULL, to = NULL) {
    converter_builder(savedlist,
                      table = "f_transaction_detail_mv",
                      from = "allocation_cd",
                      from_type = "allocation_code",
                      to = "donor_entity_id_nbr",
                      to_type = "entity_id",
                      switches = list(
                          daterange("giving_record_dt", from, to),
                          string_switch("pledged_basis_flg", "Y")
                      ),
                      aggregate_switches = sum_switch("benefit_dept_credited_amt",
                                                      at_least))
}
