Stock Data Gathering Functions
================

### Required packages

  - dplyr
  - rvest

### Yahoo\! Finance

`news_links` gives the first 15 news links from Apple’s stock, AAPL.

``` r
news.links <- news_links(stock.name = 'aapl')
head(news.links)
```

    ## [1] "/news/apple-goldman-credit-card-far-164238902.html"          
    ## [2] "/news/bulls-bears-week-apple-tesla-160428324.html"           
    ## [3] "/news/fitbit-stock-earnings-refute-bear-145620887.html"      
    ## [4] "/news/apple-holders-vote-down-proposal-121138163.html"       
    ## [5] "/news/best-cheap-phones-222441818.html"                      
    ## [6] "/news/warren-buffetts-market-indicator-breaks-212315100.html"

`stock_news` uses the links acquired from `news_links` to retrieve the
text from each news article

``` r
aapl.news <- stock_news(stock.links = news.links)
head(summary(aapl.news))
```

    ##      Length Class  Mode     
    ## [1,] 1      -none- character
    ## [2,] 1      -none- character
    ## [3,] 1      -none- character
    ## [4,] 1      -none- character
    ## [5,] 1      -none- character
    ## [6,] 1      -none- character

### Financial Documents

`sec_financial_docs` returns the links for documents to download. If the
keyword does not return a page with the document links, the user is
provided with a prompt of options to choose from. Alternatively, you can
re-run the function using the desired company name acquired from the
printed list.

``` r
### Use name from 
financial.docs <- sec_financial_docs(company.keywords = 'apple inc', items.per.page = 10)
summary(financial.docs)
```

    ##  Filing.Date          Filings          Description       
    ##  Length:10          Length:10          Length:10         
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##  Filing.Link       
    ##  Length:10         
    ##  Class :character  
    ##  Mode  :character

`download_sec_filings` downloads the documents whose info were acquired
using `sec_financial_docs` and stores them into the current working
directory

``` r
### not run
filinglink <- financial.docs$Filing.Link[[1]]
download_sec_filings(filing.link = filinglink)
```
