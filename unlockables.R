urls <-paste0("https://theshownation.com/mlb20/community_market?category_id=&amp;max_best_buy_price=&amp;max_best_sell_price=&amp;min_best_buy_price=&amp;min_best_sell_price=&amp;name=&amp;rarity_id=4&amp;sub_category_id=&amp;type=unlockable")
players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

unlockable = as.data.frame(tbls_ls)


webpage <- read_html(urls)
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

markettable = as.data.frame(tbls_ls)
unlockable=rbind(unlockable,markettable)


library(dplyr)
unlockabletable <-distinct(unlockable)
unlockabletable$Rarity <-"Diamond"
unlockabletable<- unlockabletable[,1:5]

urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:3,"&category_id=&amp=&max_best_buy_price=&max_best_sell_price=&min_best_buy_price=&min_best_sell_price=&name=&rarity_id=3&sub_category_id=&type=unlockable")
players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

utable = as.data.frame(tbls_ls)

for (i in 1:3) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  utable=rbind(utable,markettable)
}

library(dplyr)
unlockabletable1 <-distinct(utable)
unlockabletable1$Rarity <-"Gold"

unlockabletable1<- unlockabletable1[,1:5]


urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:3,"&category_id=&amp=&max_best_buy_price=&max_best_sell_price=&min_best_buy_price=&min_best_sell_price=&name=&rarity_id=2&sub_category_id=&type=unlockable")
players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

utable = as.data.frame(tbls_ls)

for (i in 1:3) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  utable=rbind(utable,markettable)
}

library(dplyr)
unlockabletable2 <-distinct(utable)
unlockabletable2$Rarity <-"Silver"

unlockabletable1<- unlockabletable1[,1:5]

unlockablecombined <-rbind(unlockabletable,unlockabletable1,unlockabletable2)




