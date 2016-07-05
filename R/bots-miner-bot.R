#' @export
miner_bot <- function(...) {
    reroute(miner_bot_(prep_dots(...)))
}

miner_bot_ <- function(search_terms) {
    gave_to_fund(fund_text_contains_(search_terms)) %or%
        contacted_entity_of(contact_text_contains_(search_terms)) %or%
        research_miner_(search_terms)
}
