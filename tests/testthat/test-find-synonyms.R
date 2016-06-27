context("find_synonyms")

test_that("find_synonyms lists all synonyms when no search string given", {
    alloc_school_df <- data.frame(synonym = names(alloc_school_code_synonyms()),
                                  code = unname(alloc_school_code_synonyms()),
                                  stringsAsFactors = FALSE)
    office_df <- data.frame(synonym = names(office_code_synonyms()),
                            code = unname(office_code_synonyms()),
                            stringsAsFactors = FALSE)


    expect_identical(find_synonyms(gave_to_area),
                     alloc_school_df)
    expect_identical(find_synonyms(in_unit_portfolio),
                     office_df)
})

test_that("find_synonyms filters synonym lists using search term", {
    df <- data.frame(synonym = names(geo_metro_area_code_synonyms()),
                     code = unname(geo_metro_area_code_synonyms()),
                     stringsAsFactors = FALSE)

    index <- grep("chicago", df$synonym)
    find_synonyms_result <- find_synonyms(lives_in_msa, "chicago")
    find_synonyms_expected <- df[index, ]

    expect_identical(find_synonyms_result,
                     find_synonyms_expected)

})

test_that("find_synonyms returns empty data frame on degenerate inputs", {
    df <- data.frame(synonym = names(geo_metro_area_code_synonyms()),
                     code = unname(geo_metro_area_code_synonyms()),
                     stringsAsFactors = FALSE)

    index <- grep("xyzxyz", df$synonym)
    find_synonyms_result <- find_synonyms(lives_in_msa, "xyzxyz")
    find_synonyms_expected <- df[index, ]

    expect_identical(find_synonyms_result,
                     find_synonyms_expected)

})
