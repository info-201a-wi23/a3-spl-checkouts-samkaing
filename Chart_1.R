# mental illness by media
library("dplyr")
library("stringr")
library("ggplot2")
spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth,  "-01" ))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

psych_df <- spl_df %>% filter(str_detect(Subjects, "psychology"))

video_disk_df <- psych_df %>% filter(str_detect(MaterialType, "VIDEODISC")) %>% group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

book_df <- psych_df %>% filter(str_detect(MaterialType, "BOOK")) %>% group_by(date) %>%
  summarize(Checkouts = sum(Checkouts, na.rm = TRUE))

high_book <- book_df %>% summarise(max(Checkouts))

high_video <- video_disk_df %>% summarise(max(Checkouts))

ggplot() + geom_line(data = video_disk_df, aes(x = date, y = Checkouts, color = "Video Disk")) + geom_line(data = book_df, aes(x = date, y = Checkouts, color = "Book")) + ggtitle("Medias of Psychology topics from 2017 to 2023")
