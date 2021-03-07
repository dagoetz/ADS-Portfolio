
urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:68,"&type=player_card")
players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

table = as.data.frame(tbls_ls)

for (i in 1:68) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  table=rbind(table,markettable)
}

library(dplyr)
dtable <-distinct(table)

