library("dplyr")
library("stringr")
library("ggplot2")

spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth,  "-01" ))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

# Chart 1 values
psych_df <- spl_df %>% filter(str_detect(Subjects, "psychology"))
video_disk_df <- psych_df %>% filter(str_detect(MaterialType, "VIDEODISC")) %>% group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))
book_df <- psych_df %>% filter(str_detect(MaterialType, "BOOK")) %>% group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

psych_high_book <- book_df %>% summarise(max(Checkouts))

psych_high_video <- video_disk_df %>% summarise(max(Checkouts))


harry_potter_df <- spl_df %>% 
  filter(str_detect(Title, "Harry Potter")) %>% 
  filter(str_detect(Creator, "Rowling")) %>%
  group_by(date) %>% summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

high_potter <- harry_potter_df %>% summarise(max(Checkouts))

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
