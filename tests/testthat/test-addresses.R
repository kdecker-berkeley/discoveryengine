context("address widgets")

test_that("address widgets work", {
    expect_is(lives_in_county(), 'listbuilder')
    expect_is(lives_in_foreign_country(), 'listbuilder')
    expect_is(lives_in_msa(), 'listbuilder')
    expect_is(lives_in_zip(), 'listbuilder')

    expect_is(works_in_county(), 'listbuilder')
    expect_is(works_in_foreign_country(), 'listbuilder')
    expect_is(works_in_msa(), 'listbuilder')
    expect_is(works_in_zip(), 'listbuilder')

    expect_is(lives_near(latitude = 37.87209, longitude = -122.2714,
                         miles = 6),
              "listbuilder")

    expect_is(works_near(latitude = 37.87209, longitude = -122.2714,
                         miles = 6),
              "listbuilder")

    expect_is(lives_near("1995 University Avenue, Berkeley CA",
                         miles = 6),
              "listbuilder")

    expect_is(works_near("1995 University Avenue, Berkeley CA",
                         miles = 6),
              "listbuilder")

    expect_is(lives_in_state(), 'listbuilder')
    expect_is(lives_in_state(CA), 'listbuilder')

    test <- works_in_state(TX)
    test %>% has_filters(
        state_code = "TX",
        addr_type_code = c("B", "I", "N"),
        contact_type_desc = 'ADDRESS',
        addr_status_code = c("A", "K")
    )

    test2 <- lives_in_state(CA, AK, include_seasonal = TRUE, include_past = TRUE)
    test2 %>% has_filters(
        state_code = c("CA", "AK"),
        addr_type_code = c("H", "S", "6", "P", "SP", "6P"),
        contact_type_desc = "ADDRESS"
    )

})

test_that("address types are correctly mapped from widget options", {
    # business widgets (should) only have past/alternate options
    expect_setequal(
        address_type_builder("business",
                             include_past = FALSE,
                             include_alternate = FALSE,
                             include_self_employed = TRUE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("B", "I")
    )

    expect_setequal(
        address_type_builder("business",
                             include_past = TRUE,
                             include_alternate = FALSE,
                             include_self_employed = TRUE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("B", "I", "Q", "J")
    )

    expect_setequal(
        address_type_builder("business",
                             include_past = FALSE,
                             include_alternate = TRUE,
                             include_self_employed = TRUE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("B", "I", "N")
    )

    expect_setequal(
        address_type_builder("business",
                             include_past = TRUE,
                             include_alternate = FALSE,
                             include_self_employed = TRUE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("B", "Q", "I", "J")
    )

    expect_setequal(
        address_type_builder("business",
                             include_past = TRUE,
                             include_alternate = TRUE,
                             include_self_employed = TRUE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("B", "Q", "I", "N", "NP", "J")
    )

    expect_setequal(
        address_type_builder("home",
                             include_past = FALSE,
                             include_alternate = TRUE,
                             include_self_employed = FALSE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("H", "6")
    )

    expect_setequal(
        address_type_builder("home",
                             include_past = FALSE,
                             include_alternate = TRUE,
                             include_self_employed = FALSE,
                             include_seasonal = TRUE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("H", "6", "S")
    )

    expect_setequal(
        address_type_builder("home",
                             include_past = TRUE,
                             include_alternate = TRUE,
                             include_self_employed = FALSE,
                             include_seasonal = TRUE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE),
        c("H", "P", "6", "6P", "S", "SP")
    )

    expect_setequal(
        address_type_builder("home",
                             include_past = TRUE,
                             include_alternate = FALSE,
                             include_self_employed = FALSE,
                             include_seasonal = FALSE,
                             include_student_local = TRUE,
                             include_student_permanent = TRUE),
        c("H", "P", "E", "L", "C", "O")
    )

    expect_setequal(
        address_type_builder("home",
                             include_past = FALSE,
                             include_alternate = FALSE,
                             include_self_employed = FALSE,
                             include_seasonal = FALSE,
                             include_student_local = TRUE,
                             include_student_permanent = TRUE),
        c("H", "E", "C")
    )

})
