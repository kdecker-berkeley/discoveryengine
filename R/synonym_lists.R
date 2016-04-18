synonyms_for <- function(type) {
    switch(type,
           alloc_school_code = alloc_school_code_synonyms(),
           school_code = school_code_synonyms(),
           office_code = office_code_synonyms(),
           dp_interest_code = dp_interest_code_synonyms(),
           NULL)
}

dp_interest_code_synonyms <- function() {
    c(
        "least" = "LEAST",
        "least_likely" = "LEAST",
        "less" = "LESS",
        "less_likely" = "LESS",
        "some" = "SOME",
        "somewhat" = "SOME",
        "somewhat_likely" = "SOME",
        "more" = "MORE",
        "more_likely" = "MORE",
        "most" = "MOST",
        "most_likely" = "MOST"
    )
}

office_code_synonyms <- function() {
    c(
        "astronomy" = "AD",
        "art_museum" = "AM",
        "bam" = "AM",
        "berkeley_art_museum" = "AM",
        "brain_initiative" = "BB",
        "berkeley_brain_initiative" = "BB",
        "blum_center" = "BM",
        "botanical_garden" = "BG",
        "business" = "BU",
        "haas" = "BU",
        "cal_alumni_association" = "CA",
        "alumni_association" = "CA",
        "caa" = "CA",
        "chemistry" = "CH",
        "class_campaigns" = "A2",
        "cfr" = "CF",
        "corporate_foundation_relations" = "CF",
        "education" = "EC",
        "engineering" = "EN",
        "environmental_design" = "ED",
        "equity_inclusion" = "EI",
        "gift_planning" = "PG",
        "planned_giving" = "PG",
        "governmental_studies" = "GS",
        "graduate_division" = "GD",
        "hearst_museum" = "HM",
        "information" = "IM",
        "athletics" = "AT",
        "international_relations" = "ID",
        "journalism" = "JR",
        "boalt" = "LW",
        "law" = "LW",
        "lawrence_hall_of_science" = "LH",
        "leadership_gifts" = "LG",
        "letters_and_science" = "LS",
        "ls" = "LS",
        "library" = "LI",
        "magnes" = "MN",
        "natural_resources" = "NR",
        "neuroscience" = "NS",
        "neuroscience_institute" = "NS",
        "optometry" = "OP",
        "principal_gifts" = "PX",
        "public_health" = "PH",
        "public_policy" = "PP",
        "gspp" = "PP",
        "qb3" = "QB",
        "quantitative_bioscience" = "QB",
        "quantitative_biosciences" = "QB",
        "social_welfare" = "SW",
        "student_affairs" = "UA",
        "young_musicians_program" = "YM",
        "ymp" = "YM"
    )
}

alloc_school_code_synonyms <- function() {
    c(
        "academic_senate" = "ACS",
        "bam" = "BAM",
        "berkeley_art_museum" = "BAM",
        "art_museum" = "BAM",
        "law" = "BLBH",
        "boalt" = "BLBH",
        "haas" = "HSB",
        "business" = "HSB",
        "cal_alumni_association" = "CAA",
        "alumni_association" = "CAA",
        "caa" = "CAA",
        "cal_performances" = "CALP",
        "chemistry" = "COC",
        "education" = "GSE",
        "engineering" = "COE",
        "environmental_design" = "CED",
        "equity_inclusion" = "EQIN",
        "graduate_division" = "GRAD",
        "athletics" = "IA",
        "journalism" = "JOUR",
        "library" = "LIB",
        "natural_resources" = "CNR",
        "public_health" = "SPH",
        "gspp" = "GSPP",
        "public_policy" = "GSPP",
        "social_welfare" = "SWS"
    )
}

school_code_synonyms <- function() {
    c(
        "business" = "BU",
        "haas" = "BU",
        "chemistry" = "CH",
        "letters_and_science" = "LS",
        "ls" = "LS",
        "natural_resources" = "NR",
        "education" = "EC",
        "engineering" = "EN",
        "environmental_design" = "ED",
        "public_policy" = "PP",
        "gspp" = "PP",
        "journalism" = "JR",
        "boalt" = "LW",
        "law" = "LW",
        "optometry" = "OP",
        "public_health" = "PH",
        "social_welfare" = "SW"
    )

}
