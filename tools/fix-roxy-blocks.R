

if(!"source:tools/utils.R" %in% search()) envir::attach_source("tools/utils.R")



missing_returns_section <- function(block) {
  # tags <- lapply(block$tags, \(t) t$tag)
  # !any(c("returns", "return") %in% tags)
  !block_has_tags(block, c("return", "returns"))
}


# modify_roxy_block_lines()

block_has_inherited_tags <- function(block, tags) {
  inherited_fields <- roxygen2::block_get_tag_value(block, "inherit")$fields
  any(tags %in% inherited_fields)
}

# Missing @returns
# walk_roxy_blocks
modify_roxy_block_lines(function(block_lines, block) {
  if (block_has_tags(block, "noRd")) return()
  if (!block_has_tags(block, "export")) return()
  if (block_has_tags(block, "describeIn")) return() # documented elsewhere
  if (block_has_tags(block, c("return", "returns"))) return()
  if (block_has_inherited_tags(block, c("return"))) return()
  file <- block$file
  line <- block$line
  if (basename(file) == "reexports.R") return()

  name <- doctether:::get_block_name(block)
  if(block_has_tags(block, "rdname") &&
     !identical(roxygen2::block_get_tag_value(block, "rdname"), name))
    return() # object is documented alongside something else


  if(inherits(block$object, "s3method")) return()

  # if (!startsWith(name, "callback_")) return()

  cli_alert_info("{name} {.file {file}:{line}}")

  # i <- which(block_lines ==  "#' @export")
  # block_lines[i] %<>% str_prefix("#' @inherit callback_backup_and_restore return\n")
  # return(block_lines)
  #

  # # browser()

  NULL
})






    # if(identical(c("y_true", "y_pred") ,
    #              (block$object$value |> formals() |> names() |> _[1:2]))) {
    # }
  # }
  # if(missing_returns_section(block)) {
  #   if(
  #     return() # taken care of already
