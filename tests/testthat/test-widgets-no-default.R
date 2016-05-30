context("widgets create listbuilder objects (non-default)", {
    expect_is(attended_event(1234), "listbuilder")
    expect_is(capacity(1:10), "listbuilder")
    expect_is(class_campaign_year(1990, 1995:2005), "listbuilder")
    expect_is(has_degree_from(SHSB), "listbuilder")
    expect_is(gave_to_area(CALP), "listbuilder")
})
