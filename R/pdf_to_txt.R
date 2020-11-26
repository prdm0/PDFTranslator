library(glue)
library(magrittr)
library(fs)
library(pdftools)

#' @title Converting a PDF to a text file
#' @importFrom magrittr `%>%`
#' @importFrom glue glue
#' @importFrom fs path_ext_remove
#' @importFrom pdftools pdf_ocr_text
#' @export
pdf_to_text <- function(file, start = NULL, end = NULL, args = NULL, show = TRUE) {
  file_name <- fs::path_ext_remove(file)

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
      pdftools::pdf_ocr_text(pages = start:end) %>%
      cat(file = glue("{file_name}.txt"))
  }

  if(isTRUE(show))
    file.edit(glue("{file_name}.txt"), title = "Generated text file")
}

# pdf_to_text(file = "/home/prdm0/Downloads/Computer Age Statistical Inference - Bradley Efron.pdf",
#             start = 2)
