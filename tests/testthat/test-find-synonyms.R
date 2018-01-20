context("find_synonyms")

test_that("find_synonyms lists all synonyms when no search string given", {

    no_search_string <- find_synonyms(gave_to_area)
    search_string <- find_synonyms(gave_to_area, "sci")

    expect_is(no_search_string, "data.frame")
    expect_is(search_string, "data.frame")
    expect_true(nrow(no_search_string) >= nrow(search_string))

    no_search_string <- find_synonyms(in_unit_portfolio)
    search_string <- find_synonyms(in_unit_portfolio, "sci")

    expect_is(no_search_string, "data.frame")
    expect_is(search_string, "data.frame")
    expect_true(nrow(no_search_string) >= nrow(search_string))
})

test_that("find_synonyms filters synonym lists using search term", {
    df <- data.frame(synonym = names(geo_metro_area_code_synonyms()),
                     code = unname(geo_metro_area_code_synonyms()),
                     stringsAsFactors = FALSE)

    index <- grep("chicago", df$synonym)
    find_synonyms_result <- find_synonyms(played_sport, "basketball")
    result_code <- find_synonyms_result$code
    expect_true("WABB" %in% result_code)
})

test_that("find_synonyms returns empty data frame on degenerate inputs", {
    expect_warning(
        find_synonyms_result <- find_synonyms(has_affiliation, "xyzxyz"),
        "No synonyms")

    find_synonyms_expected <- data.frame(
        synonym = character(), code = character(),
        stringsAsFactors = FALSE
    )

    expect_equivalent(find_synonyms_result,
                      find_synonyms_expected)
})
