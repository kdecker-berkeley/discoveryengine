context("string params")

test_that("positive (non-not()) params work", {
    expect_identical(
        string_param("degree_code", prep_dots(mba)),
        string_param("degree_code", prep_dots(MBA))
    )

    expect_identical(
        string_param("degree_code", prep_dots(mba, phd)),
        list(as.call(
            list(quote(`%in%`), quote(degree_code), c("MBA", "PHD"))
        ))
    )
})

test_that("negative (not()) params work", {
    expect_identical(
        string_param("degree_code", prep_dots(not(mba))),
        string_param("degree_code", prep_dots(not(MBA)))
    )

    expect_identical(
        string_param("degree_code", prep_dots(not(mba, phd))),
        string_param("degree_code", prep_dots(not(mba), not(phd)))
    )

    expect_identical(
        string_param("degree_code", prep_dots(not(mba, phd))),
        list(as.call(
            list(quote(`%not in%`), quote(degree_code), c("MBA", "PHD"))
        ))
    )

    expect_error(string_param("degree_code", prep_dots(not(mba), phd)))

    expect_identical(
        reroute(string_param("degree_code", prep_dots(not(?mba)))),
        reroute(string_param("degree_code", prep_dots(?mba)))
    )

    expect_identical(
        reroute(string_param("degree_code", prep_dots(not(?mba, ?phd)))),
        reroute(string_param("degree_code", prep_dots(?mba, ?phd)))
    )

    expect_identical(
        reroute(string_param("degree_code", prep_dots(not(?mba), not(?phd)))),
        reroute(string_param("degree_code", prep_dots(not(?mba, ?phd))))
    )

    # evaluates in tms-code-space first, then outside
    business <- "chemistry"
    expect_identical(
        reroute(string_param("school_code", prep_dots(business))),
        list(quote(school_code %in% 'BU'))
    )
})
