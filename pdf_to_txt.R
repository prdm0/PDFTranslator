library(glue)
library(magrittr)
library(fs)

pdf_to_text <- function(file, start = NULL, end = NULL, args = NULL) {
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
}

# pdf_to_text(file = "/home/prdm0/Downloads/traducao/An Introduction to Statistical Learning_ W - Gareth James.pdf",
#             start = 40, end = 45)