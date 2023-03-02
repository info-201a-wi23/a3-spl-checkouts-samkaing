#Chart 2: the trend of hunger games, twilight, lord of the rings, a game of thrones throughout the years
library("dplyr")
library("stringr")
library("ggplot2")
spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth,  "-01" ))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

harry_potter_df <- spl_df %>% 
  filter(str_detect(Title, "Harry Potter")) %>% 
  filter(str_detect(Creator, "Rowling")) %>%
  group_by(date) %>% summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

avg_potter <- harry_potter_df %>% summarise(mean(Checkouts))

twilight_df <- spl_df %>% 
  filter(str_detect(Title, "Twilight")) %>%
  filter(str_detect(Creator, "Meyer")) %>%
  group_by(date) %>% summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

avg_twilight <- twilight_df %>% summarise(mean(Checkouts))

martin_df <- spl_df %>% 
  filter(str_detect(Creator, "Martin")) %>%
  filter(str_detect(Creator, "George")) 

asoiaf_df <- martin_df %>% filter(str_detect(Title, "A")) %>%
  group_by(date) %>% summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

avg_asoiaf <- asoiaf_df %>% summarise(mean(Checkouts))

lotr_df <- spl_df %>% 
  filter(str_detect(Title, "Lord of the Rings")) %>%
  filter(str_detect(Creator, "Tolkien")) %>%
  group_by(date) %>% summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

ggplot() + geom_line(data = asoiaf_df, aes(x = date, y = Checkouts, color = "A Song of Ice and Fire Series")) + geom_line(data = twilight_df, aes(x = date, y = Checkouts, color = "Twilight Series")) + geom_line(data = harry_potter_df, aes(x = date, y = Checkouts, color = "Harry Potter Series")) + geom_line(data = lotr_df, aes(x = date, y = Checkouts, color = "The Lord of the Rings")) + ggtitle("Book Series Checkouts 2017 to 2023")