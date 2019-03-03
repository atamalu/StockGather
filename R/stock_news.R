stock_news <- function(stock.links){

  ### Make large list to hold each page's data
  news.list <- list()
  i <- 1

  ### scrape each news page
  for(link in stock.links){

    url <- paste0('https://finance.yahoo.com', link)

    page.text <- url %>%
      read_html() %>%
      html_nodes('p')

    page.text <- html_text(page.text)

    ################## step here

    ### bind all remaining news items
    page.text <- paste(page.text, collapse = " ")

    ### add to list at index i
    news.list[[i]] <- page.text

    i <- i + 1

  }

  return(news.list)

}
