context("attended_event specifications")
source("helpers.R")
library(magrittr)
particip <- c('P', 'ST', 'SP', 'V', 'H', 'S', 'C', 'KN', 'MD', 'E', 'OL')

test_that("attended_event meets specifications on standard input", {
    test <- attended_event(47, 4827)
    test %>% uses_table("d_bio_activity_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(activity_code = c("47", "4827"),
                    activity_participation_code = particip)

    attended_event(123, 457, include_non_attendees = TRUE) %>%
        has_filters(activity_code = c("123", "457"),
                    activity_participation_code = c(particip, "ID", "RG", "NS"))

})

test_that("attended_event meets specifications on no input", {
    attended_event() %>%
        has_filters(activity_participation_code = particip)
})
