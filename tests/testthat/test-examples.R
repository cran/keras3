context("examples")



# some helpers
run_example <- function(example) {
  env <- new.env()
  capture.output({
    example_path <- system.file("examples", example, package = "keras3")
    old_wd <- setwd(dirname(example_path))
    on.exit(setwd(old_wd), add = TRUE)
    source(basename(example_path), local = env)
  }, type = "output")
  rm(list = ls(env), envir = env)
  gc()
}

examples <- if (nzchar(Sys.getenv("KERAS_TEST_EXAMPLES")) &&
                nzchar(Sys.getenv("KERAS_TEST_ALL"))) {
  c("simple.R")
}

for (example in examples) {
  test_that(paste(example, "example runs successfully"), {
    skip_if_no_keras()
    expect_error(run_example(example), NA)
  })
}
