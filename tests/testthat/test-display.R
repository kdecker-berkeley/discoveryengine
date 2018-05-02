context("display")

test_that("display returns a dataframe, regardless of file argument", {
    sample_constituency <- has_capacity(1)
    sample_report <- discoappend::basic_bio(sample_constituency)

    file1 <- tempfile(fileext = ".csv")
    file2 <- tempfile(fileext = ".csv")

    constituency_no_file <- display(sample_constituency)
    constituency_file <- display(sample_constituency, file = file1)

    expect_identical(constituency_no_file, constituency_file)

    report_no_file <- display(sample_report)
    report_file <- display(sample_report, file = file2)

    expect_identical(report_no_file, report_file)

    expect_true(file.exists(file1))
    expect_true(file.exists(file2))
})
