dl_sec_doc <- function(doc.suffix, file.name){

  doc.url <- sub("/[^/]+$", "", url)
  doc.url <- paste0(doc.url, '/', doc.suffix)

  ### get document
  file.name <- gsub("[^[:alnum:] ]", "", file.name)
  file.extension <- sub('.*\\.', '', doc.suffix)

  file.name <- paste0(file.name, '.', file.extension)

  download.file(url = doc.url, destfile = file.name)

}

download_sec_filings <- function(filing.link){

  url <- paste0('https://www.sec.gov', filing.link)

  tryCatch(
    webpage <- url %>%
      read_html() %>%
      html_nodes('table') %>%
      html_table() %>%
      .[[1]]

    ,

    error = function(e){
      'Invalid link or no available files. Please provide a new link.'
    }
  )

  ### Download files

  tryCatch(
    Map(dl_sec_doc, webpage$Document, webpage$Description)
    ,
    error = function(e){
      print(paste0('Unable to download file', webpage$Document))
    }
  )
}
