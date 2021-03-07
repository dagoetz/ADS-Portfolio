urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:4,"brand_id=&amp;max_best_buy_price=&amp;max_best_sell_price=&amp;min_best_buy_price=&amp;min_best_sell_price=&amp;name=&amp;rarity_id=4&amp;slot_type_id=&amp;type=equipment")


players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

equiptable = as.data.frame(tbls_ls)

for (i in 1:4) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  equiptable=rbind(equiptable,markettable)
}

equiptable$Rarity <- "Diamond"


urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:3,"&brand_id=&amp=&max_best_buy_price=&max_best_sell_price=&min_best_buy_price=&min_best_sell_price=&name=&rarity_id=3&slot_type_id=&type=equipment")


players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

equiptable1 = as.data.frame(tbls_ls)

for (i in 1:3) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  equiptable1=rbind(equiptable1,markettable)
}

equiptable1$Rarity <- "Gold"


urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:3,"&brand_id=&amp=&max_best_buy_price=&max_best_sell_price=&min_best_buy_price=&min_best_sell_price=&name=&rarity_id=2&slot_type_id=&type=equipment")

players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

equiptable2 = as.data.frame(tbls_ls)

for (i in 1:3) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  equiptable2=rbind(equiptable2,markettable)
}

equiptable2$Rarity <- "Silver"


urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:3,"&brand_id=&amp=&max_best_buy_price=&max_best_sell_price=&min_best_buy_price=&min_best_sell_price=&name=&rarity_id=2&slot_type_id=&type=equipment")

players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

equiptable2 = as.data.frame(tbls_ls)

for (i in 1:3) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  equiptable2=rbind(equiptable2,markettable)
}

equiptable2$Rarity <- "Silver"


equipmentcombined <-rbind(equiptable,equiptable1,equiptable2)
equipmentcombined <-distinct(equipmentcombined)
