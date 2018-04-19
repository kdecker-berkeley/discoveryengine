context("bot results can be converted to code")

test_that("brainstorm_bot results can be viewed as code", {
    bb <- brainstorm_bot("neuroscience")
    bbcode <- as_code(bb)
    expect_is(bbcode, "character")
    expect_length(bbcode, 1L)
    re_bb <- eval(parse(text = bbcode))
    expect_identical(to_sql(re_bb), to_sql(bb))
})

test_that("matrix_bot results can be viewed as code", {
    mb <- matrix_bot(majored_in(540))
    mbcode <- as_code(mb)
    expect_is(mbcode, "character")
    expect_length(mbcode, 1L)
    re_mb <- eval(parse(text = mbcode))
    expect_identical(to_sql(re_mb), to_sql(mb))
})
