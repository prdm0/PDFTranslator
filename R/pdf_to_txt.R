library(glue)
library(magrittr)
library(fs)
library(pdftools)

#' @title Converting a PDF to a text file
#' @importFrom magrittr `%>%`
#' @importFrom glue glue
#' @importFrom fs path_ext_remove file_show
#' @importFrom pdftools pdf_ocr_text pdf_text pdf_subset
#' @export
pdf_to_text <- function(file, start = NULL, end = NULL, show = TRUE) {
  file_name <- fs::path_ext_remove(file)

  if(is.null(start))
    stop("Enter a page for the start argument.")

  if(is.null(end))
    end <- start

  file %>%
  pdftools::pdf_subset(pages = start:end) %>%
  pdftools::pdf_text() %>%
  cat(file = glue("{file_name}.txt"))

  if(length(readLines(glue("{file_name}.txt"), warn = FALSE)) == 1L) {
      glue("{file}") %>%
      pdftools::pdf_ocr_text(pages = start:end) %>%
      cat(file = glue("{file_name}.txt"))
  }

  if(isTRUE(show))
    fs::file_show(glue("{file_name}.txt"))
}

pdf_to_text(file = "/home/prdm0/Downloads/Computer Age Statistical Inference - Bradley Efron.pdf",
            start = 1, show = FALSE)
