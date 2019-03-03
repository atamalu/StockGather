### Can only use alphanumeric inputs on website; therefore function works that way also

sec_financial_docs <- function(company.keywords, items.per.page = 40){

  ### make url with keywords
  company.keywords <- gsub(' ', '+', company.keywords)
  url <- paste0('https://www.sec.gov/cgi-bin/browse-edgar?company=', company.keywords, '&owner=exclude&count=', items.per.page, '&action=getcompany')

  ### get url
  ## div 'mailer' class appears if the keyword hits a company, otherwise page with list of companies appear

  webpage <- url %>%
    read_html() %>%
    html_nodes('div.mailer')

  ### do if mailer isn't found
  if(length(webpage) == 0){

    # get intermediate webpage
    webpage <- url %>%
      read_html() %>%
      html_nodes('table') %>%
      html_table() %>%
      as.data.frame()

    # format for printing and get user input
    webpage$Company <- substr(webpage$Company, start = 0, stop = 25)

    print('Please enter the CIK of desired page. Options have been printed below in console.')
    print(webpage[1:2])

    CIK <- scan(n = 1)

    # get url of company
    url <- paste0('https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=', CIK, '&owner=exclude&count=', items.per.page, '&hidefilings=0')

  }

  ##### Pt. 2 ---------------

  ### Make base url
  webpage <- url %>%
    read_html()

  ### Get file names to locate types of files
  page.links <- webpage %>%
    html_nodes('a#documentsbutton') %>%
    html_attr('href')

  tryCatch(
    ### Get full table
    page.table <- webpage %>%
      html_nodes('table.tableFile2') %>%
      html_table() %>%
      .[[1]],

    error = function(e){
      print('No records found. Please retry and select another keyword or option from the menu.')
    }
  )

  ##### Pt. 3: Return data frame ---------------

  ### Keep only necessary info
  return.frame <- data.frame(
    Filing.Date = page.table$`Filing Date`,
    Filings = page.table$Filings,
    Description = page.table$Description,
    Filing.Link = page.links,
    stringsAsFactors = FALSE
  )

  return(return.frame)

}
