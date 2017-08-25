context("id params")

test_that("entity_id_param can accept inputs in multiple formats", {
    showme <- function(x)
        dplyr::arrange(
            display(x, include_organizations = TRUE,
                    include_deceased = TRUE, household = FALSE), entity_id)

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
        showme(entity_id_param(has_capacity(1))),
        showme(has_capacity(1))
    )

    expect_equal(
        showme(entity_id_param(has_capacity(1), 640993)),
        showme(has_capacity(1) %or% entities(640993))
    )

    expect_equal(
        showme(entity_id_param(has_capacity(1), entities(640993))),
        showme(has_capacity(1) %or% entities(640993))
    )

    temp <- c(548769, 3004587)
    expect_equal(
        showme(entity_id_param(temp)),
        data.frame(entity_id = c(548769, 3004587))
    )

    big_def = entity_id_param(
        1234,
        entities(57575, 37374),
        has_capacity(1),
        "4576",
        temp,
        347*5)

    expect_equal(
        showme(big_def),
        showme(
            has_capacity(1) %or%
                entities(1234, 57575, 37374, 4576, 548769, 3004587, 1735)
        )
    )

    expect_error(entity_id_param(funds(FW1737)),
                 "Expected entity IDs")
})

test_that("allocation_id_param can accept inputs in multiple formats", {
    showme <- function(x) dplyr::arrange(
        display(x), allocation_code
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
})
