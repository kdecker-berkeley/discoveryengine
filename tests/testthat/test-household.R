context("household")
source("helpers.R")

test_that("household is using the household id not the primary giving id", {
    hh_def <- household(entities(48965, 32874))
    expect_identical(
        listbuilder::get_id_field(hh_def),
        "household_entity_id"
    )
})
