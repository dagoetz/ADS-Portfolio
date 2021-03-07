urls <-paste0("https://theshownation.com/mlb20/community_market?page=",1:3,"&type=sponsorship")
players={}

webpage <- read_html(urls[1])
tbls <- html_nodes(webpage, "table")

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  .[1:1] %>%
  html_table(fill = TRUE)

stable = as.data.frame(tbls_ls)

for (i in 1:3) {
  webpage <- read_html(urls[i])
  tbls <- html_nodes(webpage, "table")
  
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1:1] %>%
    html_table(fill = TRUE)
  
  markettable = as.data.frame(tbls_ls)
  stable=rbind(stable,markettable)
}
stable$Rarity[1:9] <-"Diamond"
stable$Rarity[10:18] <-"Gold"
stable$Rarity[19:25] <-"Silver"
stable$Rarity[26:34] <-"Diamond"
stable$Rarity[35:43] <-"Gold"
stable$Rarity[44:50] <-"Silver"
stable$Rarity[51:55] <-"Diamond"
stable$Rarity[76:83] <-"Diamond"
stable$Rarity[56:63] <-"Gold"
stable$Rarity[64:75] <-"Silver"
stable$Rarity[84:88] <-"Gold"
stable$Rarity[89:91] <-"Silver"

stable <-distinct(stable)

