readcsv <- memoise::memoise(read.csv,
                            cache = memoise::cache_memory(algo = "sha512"))

systemfile <- memoise::memoise(system.file,
                               cache = memoise::cache_memory(algo = "sha512"))
