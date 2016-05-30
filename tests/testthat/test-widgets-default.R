context("widgets have defined default behavior", {
    expect_is(attended_event(), "listbuilder")
    expect_is(capacity(), "listbuilder")
    expect_is(class_campaign_year(), "listbuilder")
    expect_is(has_degree_from(), "listbuilder")
    expect_is(gave_to_area(), "listbuilder")
})
