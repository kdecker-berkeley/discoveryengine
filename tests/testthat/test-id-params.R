context("id params")

test_that("entity_id_param can accept inputs in multiple formats", {
    showme <- function(x)
        dplyr::arrange(
            get_cdw(x), entity_id)

    expect_equal(
        showme(entity_id_param(1234)),
        data.frame(entity_id = 1234)
    )

    expect_equal(
        showme(entity_id_param(1234, 5757)),
        data.frame(entity_id = c(1234, 5757))
    )

    expect_equal(
        showme(entity_id_param(entities(1234, 5757))),
        data.frame(entity_id = c(1234, 5757))
    )

    expect_equal(
        entity_id_param(has_capacity(1)),
        has_capacity(1)
    )

    ## these should be equivalent up to ordering of the disjuncts
    ## since it's 'or', the order is unimportant

    expect_equalish <- function(object, disjunct) {
        act <- quasi_label( rlang::enquo(object) )
        exp <- quasi_label( rlang::enquo(disjunct))
        alternative <- disjunct
        alternative$rhs <- disjunct$lhs
        alternative$lhs <- disjunct$rhs
        condition <- isTRUE(all.equal(object, disjunct)) ||
            isTRUE(all.equal(object, alternative))
        expect(condition,
               failure_message = sprintf("%s \ndoes not equal (up to disjunct order) \n%s.",
               act$lab, exp$lab))
        invisible(act$val)
    }

    expect_equalish(
        entity_id_param(has_capacity(1), 640993),
        has_capacity(1) %or% entities(640993)
    )

    expect_equalish(
        entity_id_param(has_capacity(1), entities(640993)),
        has_capacity(1) %or% entities(640993)
    )

    temp <- c(548769, 3004587)
    expect_equal(
        entity_id_param(temp),
        entities(548769, 3004587)
    )

    big_def = entity_id_param(
        1234,
        entities(57575, 37374),
        has_affiliation(X14),
        "4576",
        temp,
        347*5)

    expect_equal(
        showme(big_def),
        showme(
            has_affiliation(X14) %or%
                entities(1234, 57575, 37374, 4576, 548769, 3004587, 1735)
        )
    )

    expect_equal(
        showme(entity_id_param(not(1234, entities(57575, 37374),
                                   has_affiliation(X14),
                                   has_record_type(IS, PA, ST, PA, PX,
                                                   IN, AU, PX, AG, GA, UA)))),
        showme(
            is_a(include_deceased = TRUE) %but_not%
                (has_affiliation(X14) %or% has_record_type(IS, PA, ST, PA, PX,
                                                           IN, AU, PX, AG, GA, UA))
        )
    )

    expect_error(entity_id_param(funds(FW1737)),
                 "Expected entity IDs")
})

test_that("allocation_id_param can accept inputs in multiple formats", {
    showme <- function(x) dplyr::arrange(
        get_cdw(x), allocation_code
    )

    df <- function(...) data.frame(..., stringsAsFactors = FALSE)

    expect_error(allocation_id_param(prep_dots(entities(1234))),
                 "Expected allocation codes")

    allocs <- prep_dots(FW2347, funds(FW5737), "FS3737", paste0("S", "037398"))
    expect_equal(
        showme(allocation_id_param(allocs)),
        df(allocation_code = c("FS3737", "FW2347", "FW5737", "S037398"))
    )

    expect_equal(
        showme(allocation_id_param(prep_dots(funds(FW37373)))),
        df(allocation_code = 'FW37373')
    )

    expect_equal(
        showme(allocation_id_param(prep_dots(funds(FW37373, F87)))),
        df(allocation_code = c('FW37373', 'F87'))
    )

    expect_equal(
        showme(allocation_id_param(prep_dots(funds(F1), funds(F2, F3)))),
        df(allocation_code = c("F1", "F2", "F3"))
    )

    temp <- "S546"
    expect_equal(
        showme(allocation_id_param(prep_dots(temp))),
        df(allocation_code = "S546")
    )

    allocs <- fund_text_contains("neuro*")
    expect_is(gave_to_fund(allocs), "listbuilder")
    expect_is(allocation_id_param(prep_dots(allocs)), "listbuilder")

    allocs <- fund_text_contains("neuro*")
    expect_is(gave_to_fund(allocs, FW773893), "listbuilder")
    expect_is(allocation_id_param(prep_dots(allocs)), "listbuilder")

    expect_equal(
        allocation_id_param(prep_dots(not(FW77339))),
        funds() %but_not% funds(FW77339)
    )
})
