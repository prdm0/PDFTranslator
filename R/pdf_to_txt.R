library(glue)
library(magrittr)
library(fs)
library(pdftools)


#' @importFrom glue glue
#' @importFrom magrittr `%>%`
#' @importFrom fs path_ext_remove
#' @importFrom pdftools pdf_ocr_text
pdf_to_text <- function(file, start = NULL, end = NULL, args = NULL, show = TRUE) {
  file_name <- path_ext_remove(file)

  if(is.null(args))
    args <- "-layout"

  if(is.null(start)) {
    interval <- ""
  } else {
    if(is.null(end)) {
      end <- start
    }
    interval <- glue("-f {start} -l {end}")
  }

  args <- glue("{args} {interval}")

  glue("pdftotext {args} '{file}' '{file_name}.txt'") %>%
  system()

  if(length(readLines(glue("{file_name}.txt"), warn = FALSE)) == 1L) {
      glue("{file}") %>%
      pdf_ocr_text(pages = start:end) %>%
      cat(file = glue("{file_name}.txt"))
  }

  if(isTRUE(show))
    file.edit(glue("{file_name}.txt"), title = "Generated text file")
}

pdf_to_text(file = "/home/prdm0/Downloads/Computer Age Statistical Inference - Bradley Efron.pdf",
            start = 2)
