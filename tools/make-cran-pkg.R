
list.files("vignettes", pattern = "\\.Rmd$",
           recursive = TRUE, full.names = TRUE) |>
  lapply(function(f) {
    x <- readLines(f)
    x <- gsub("https://rstd.io/dlwr-2e",
              "https://www.manning.com/books/deep-learning-with-r-second-edition", x, fixed = TRUE)
    writeLines(x, f)
  })


devtools::build(manual = TRUE)

withr::with_dir("..", {
  system("R CMD check --as-cran keras3_*.tar.gz")
})
