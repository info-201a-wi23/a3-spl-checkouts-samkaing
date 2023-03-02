# a graph on most popular CoHo books 
library("dplyr")
library("stringr")
library("ggplot2")
spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

coho_df <- spl_df %>% 
  filter(str_detect(Creator, "Colleen")) %>% 
  filter(str_detect(Creator, "Hoover")) %>%
  group_by(Title) %>% 
  summarize(Checkouts = sum(Checkouts))

it_ends_with_us_df <- coho_df %>% 
  filter(str_detect(Title, "It Ends with Us")) %>% 
  summarize(Title = "It Ends with Us", Checkouts = sum(Checkouts))

it_starts_with_us_df <- coho_df %>% 
  filter(str_detect(Title, "It Starts with Us")) %>% 
  summarize(Title = "It Starts with Us", Checkouts = sum(Checkouts))

verity_df <- coho_df %>% 
  filter(str_detect(Title, "Verity")) %>% 
  summarize(Title = "Verity", Checkouts = sum(Checkouts))

ugly_love_df <- coho_df %>% 
  filter(str_detect(Title, "Ugly Love")) %>% 
  summarize(Title = "Ugly Love", Checkouts = sum(Checkouts))

ggplot() + geom_col(data = it_ends_with_us_df, aes(x = Title, y = Checkouts)) + geom_col(data = verity_df, aes(x = Title, y = Checkouts)) + geom_col(data = ugly_love_df, aes(x = Title, y = Checkouts)) + geom_col(data = it_starts_with_us_df, aes(x = Title, y = Checkouts)) + ggtitle("Colleen Hoover's most popular books from 2017 to 2023")
