context("defaults")
test_that("widgets have defined default behavior", {
    expect_is(attended_event(), "listbuilder")
    expect_is(contact_unit(), "listbuilder")
    expect_is(fund_area(), "listbuilder")
    expect_is(fund_department(), "listbuilder")
    expect_is(gave_to_area(), "listbuilder")
    expect_is(gave_to_department(), "listbuilder")
    expect_is(has_affiliation(), "listbuilder")
    expect_is(has_capacity(), "listbuilder")
    expect_is(has_degree_from(), "listbuilder")
    expect_is(has_gift_planning_score(), "listbuilder")
    expect_is(has_implied_capacity(), "listbuilder")
    expect_is(has_interest(), "listbuilder")
    expect_is(has_major_gift_score(), "listbuilder")
    expect_is(has_occupation(), "listbuilder")
    expect_is(has_philanthropic_affinity(), "listbuilder")
    expect_is(has_position(), "listbuilder")
    expect_is(has_record_type(), "listbuilder")
    expect_is(has_reunion_year(), "listbuilder")
    expect_is(in_development_officer_portfolio(), "listbuilder")
    #expect_is(in_suspect_pool(), "listbuilder")
    expect_is(in_unit_portfolio(), "listbuilder")
    expect_is(is_a(), "listbuilder")
    expect_is(lives_in_county(), "listbuilder")
    expect_is(lives_in_msa(), "listbuilder")
    expect_is(lives_in_zip(), "listbuilder")
    expect_is(majored_in(), "listbuilder")
    expect_is(on_committee(), "listbuilder")
    expect_is(participated_in(), "listbuilder")
    expect_is(played_sport(), "listbuilder")
    expect_is(received_award(), "listbuilder")
    expect_is(works_in_county(), "listbuilder")
    expect_is(works_in_industry(), "listbuilder")
    expect_is(works_in_msa(), "listbuilder")
    expect_is(works_in_zip(), "listbuilder")
})


# list.files("R/") %>%
#     grep("^widget-", ., value = T) %>%
#     str_match("-([^\\.]+)\\.R") %>%
#     "["(,2) %>%
#     str_replace_all("-", "_") %>%
#     paste("expect_is(", ., '(), "listbuilder")', sep = "") %>%
#     paste(collapse = "\n") %>%
#     cat(file = file("clipboard"))
