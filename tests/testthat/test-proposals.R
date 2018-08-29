context("proposal widgets")

test_that("proposal widgets work", {
    expect_is(proposal_office(), "listbuilder")
    expect_is(proposal_office(business), "listbuilder")
    expect_is(proposal_actual_ask(), "listbuilder")
    expect_equal(
        listbuilder::get_where(proposal_actual_ask(100000)),
        list(
            quote(actual_ask_amt >= 100000),
            quote(assigned_at_ask %in% "Y")
        )
    )
    expect_is(proposal_stage(QU), "listbuilder")
    expect_equivalent(
        listbuilder::get_where(proposal_stage(QU)),
        list(quote(current_stage %in% "QU"))
    )

    expect_identical(
        listbuilder::get_id_type(proposal_contact(proposal_stage(QU))),
        "contact_report_id"
    )

    expect_identical(
        listbuilder::get_id_type(proposal_entity(proposal_development_officer(3212545))),
        "entity_id"
    )

    expect_is(proposal_purpose(LW), "listbuilder")
    expect_is(proposal_type(major_gift), "listbuilder")
    expect_equal(
        listbuilder::get_where(proposal_qualified(from = 20180101)),
        list(
            quote(stage_transition_date >= to_date(20180101L, "yyyymmdd")),
            quote(stage_from %in% "QU"),
            quote(stage_to %in% c('CU', 'SP', 'PD', 'GS', 'DS')),
            quote(assigned_at_transition %in% "Y")
        )
    )
})
