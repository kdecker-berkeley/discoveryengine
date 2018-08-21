context("zipcode params")

test_that("positive (non-not()) zipcode params work", {
    expect_identical(
        zipcode_param("zipcode5", prep_dots(94720)),
        zipcode_param("zipcode5", prep_dots(94720))
    )

    expect_identical(
        zipcode_param("zipcode5", prep_dots(94720, 94609)),
        list(as.call(
            list(quote(`%in%`), quote(zipcode5), c("94720", "94609"))
        ))
    )

    expect_identical(
        zipcode_param("zipcode5", prep_dots(00575)),
        list(as.call(
            list(quote(`%in%`), quote(zipcode5), c("00575"))
        ))
    )
})

test_that("positive (non-not()) zipcode params work", {
    expect_identical(
        zipcode_param("zipcode5", prep_dots(not(94720, 94609))),
        zipcode_param("zipcode5", prep_dots(not(94720), not(94609)))
    )

    expect_identical(
        zipcode_param("zipcode5", prep_dots(not(94720, 94609))),
        list(as.call(
            list(quote(`%not in%`), quote(zipcode5), c("94720", "94609"))
        ))
    )

    expect_error(zipcode_param("zipcode5", prep_dots(not(94720), 94609)))

    expect_identical(
        zipcode_param("zipcode5", prep_dots(not(00123, 57578))),
        list(as.call(
            list(quote(`%not in%`), quote(zipcode5), c("00123", "57578"))
        ))
    )
})
