context("defaults")
test_that("widgets have defined default behavior", {
    expect_is(attended_event(), "listbuilder")
    expect_is(class_campaign_year(), "listbuilder")
    expect_is(gave_to_area(), "listbuilder")
    expect_is(has_affiliation(), "listbuilder")
    expect_is(has_capacity(), "listbuilder")
    expect_is(has_degree_from(), "listbuilder")
    expect_is(has_implied_capacity(), "listbuilder")
    expect_is(has_interest(), "listbuilder")
    expect_is(has_major_gift_score(), "listbuilder")
    expect_is(has_philanthropic_affinity(), "listbuilder")
    expect_is(in_unit_portfolio(), "listbuilder")
    expect_is(lives_in_county(), "listbuilder")
    expect_is(lives_in_msa(), "listbuilder")
    expect_is(lives_in_zip(), "listbuilder")
    expect_is(on_committee(), "listbuilder")
    expect_is(participated_in(), "listbuilder")
    expect_is(played_sport(), "listbuilder")
    expect_is(received_award(), "listbuilder")
    expect_is(works_in_county(), "listbuilder")
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
