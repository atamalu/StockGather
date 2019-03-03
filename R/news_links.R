news_links <- function(stock.name){

  ### Get master webpage
  url <- paste0('https://finance.yahoo.com/quote/', stock.name, '?p=', stock.name)

  all.links <- url %>%
    read_html() %>%
    html_nodes('a') %>%
    html_attr('href')

  ### Extract the news page urls
  ## links we need contain "/news/"
  link.locations <- grepl('/news/', all.links)
  stock.links <- all.links[link.locations]

  return(stock.links)

}
