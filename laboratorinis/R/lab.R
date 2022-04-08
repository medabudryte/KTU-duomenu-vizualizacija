library(readr)
library(tidyverse)

#reads data
data = read.csv("lab_sodra.csv")
summary(data)

#1
#filters data by my unique ecoActCode

data_1 = data %>%
  filter(ecoActCode == 681000)

#creates diagram of average firms wages
data_1 %>%
  ggplot(aes(x = avgWage)) +
  theme_minimal() +
  geom_histogram(fill = "blue", col = "black", bins =100) +
  labs(title = "Average wage of employees")

#2
#selects top 5 firms by average wage
top5 = data_1 %>% 
  group_by(name) %>% 
  summarise(wage = max(avgWage)) %>% 
  arrange(desc(wage)) %>% 
  head(5)


#selects top 5 firms data
data_2 = data_1 %>% filter(name %in% top5$name)

#graphics of top 5 firms average wage of employees
data_2 %>%
  ggplot(aes(x = month, y = avgWage, group = name)) +
  theme_minimal() +
  geom_line(aes(colour = name)) +
  labs(title = "Average wage of employees", x = "month", y = "avgWage")

#3
#graphics of top 5 firms insured employees number
data_2 %>%
  group_by(name) %>%
  slice_max(numInsured, with_ties = FALSE) %>%
  head(5) %>%
  ggplot(aes(x = reorder(name, -numInsured), y = numInsured)) +
  geom_col(aes(fill = name)) +
  theme(axis.text.x = element_blank()) +
  theme_minimal() +
  labs(title = "Number of insured employees", x = "name", y = "apdraustieji")
