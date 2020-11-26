library(png)
library(tesseract)

# sudp pacman -S tesseract tesseract-data-eng

txt <- pdftools::pdf_ocr_text("/home/prdm0/Downloads/pagina.pdf")

cat(txt, file = "/home/prdm0/Downloads/pagina.txt")

pdf <- "/home/prdm0/Downloads/uma_pagina.pdf"

