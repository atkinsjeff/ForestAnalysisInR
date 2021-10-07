# This script uses Web of Science data collected October, 2021 to
# look at the usage of R across manuscripts by citation
# See Atkins et al. (XXXX) for full description

# required packages
require(ggplot2)
require(tidyverse)
require(data.table)


# Section one looks at R cited by various WoS research areas
# between 2010 and 2020; Creates Figure 1 in Atkins et al. (XXXX)


#### new code

# importing journal title
filenames <- list.files(path = "./inst/extdata/bibliometrics/", pattern = "R_cites", full.names = TRUE)
l <- lapply(filenames, fread, select = c("Web of Science Categories", "Record Count"), sep = "\t", nrows =100)

names(l) <- basename(filenames)
#bind the rows from the list togetgher, putting the filenames into the colum "id"
df.rcites <- rbindlist( l, idcol = "id" )

df.rcites$year <- as.numeric(substr(df.rcites$id, 9, 13))

# format down to what we want
df.rcites  %>%
  filter(`Web of Science Categories` %in% c("Biodiversity Conservation", "Ecology", "Environmental Sciences", "Forestry",
                                            "Water Resources", "Remote Sensing", "Soil Science", "Limnology")) %>%
  data.frame() -> x

##### bring in total articles
df.totalpubs <- read.csv("./inst/extdata/bibliometrics/research_areas_articles_2010_2020.csv")
unique(df.totalpubs$research_area)

# change names to merge well
colnames(df.rcites) <- c("id", "research.area", "r.cites", "year")
colnames(df.totalpubs) <- c("research.area", "year", "all.records")

# merge together
df <- merge(df.totalpubs, df.rcites)
df$research.area <- as.factor(df$research.area)
#
x11(width = 8, height = 3)
ggplot(df, aes(x = as.integer(year), y = ((r.cites/all.records) * 100), color = research.area)) +
  geom_line(size = 2, alpha = 0.6)+
  geom_point(size = 3, shape = 21, fill = "white")+
  scale_color_manual(  name = "Research Area",
                       values = c(
                         "Biodiversity Conservation" = "#e41a1c",
                         "Ecology" ="#377eb8",
                         "Environmental Sciences" = "#4daf4a",
                         "Forestry" = "#984ea3",
                         "Limnology" ="#ff7f00",
                         "Remote Sensing" = "dark grey",
                         "Soil Sciences" = "#a65628",
                         "Water Resources" = "black"))+
  theme_minimal()+
  xlab("")+
  ylab(expression(atop("Literature Citing", paste("the R Programming Language (%)"))))+
  scale_x_continuous(
    labels = scales::number_format(accuracy = 1, big.mark = ""))









# Section two compares forestry to ecology using WoS data curated in May, 2020
# with journal specific information


# importing journal title
filenames <- list.files(path = "./inst/extdata/bibliometrics/", pattern = "_journal_", full.names = TRUE)
l <- lapply(filenames, fread, select = c("Source Titles", "records"), sep = "\t", nrows = 50)

names(l) <- basename(filenames)
#bind the rows from the list togetgher, putting the filenames into the colum "id"
df.journals <- rbindlist( l, idcol = "id" )

journal.list <- data.frame(unique(df.journals$`Source Titles`))
df.journals$year <- as.numeric(substr(df.journals$id, 0, 4))


# brings in the top 20 journals per Google Metrics
classes <- read.csv("./inst/extdata/bibliometrics/journal_classes.csv")

# moves to upper case
classes$journal_title <- as.factor(toupper(classes$journal_title))

names(df.journals)[2] <- "journal_title"

# reformat for merging
df.journals$id <- NULL
df.journals$journal_title <- as.factor(df.journals$journal_title)

df <- merge(df.journals, classes)

df %>%
  group_by(class, year) %>%
  summarize(sum.recs = sum(records)) -> df.sums

# total ecology pubs
total.eco <- read_delim("./inst/extdata/bibliometrics/total_ecology_pubs_by_year.txt", delim = "\t")
names(total.eco)[1] <- "year"
total.eco <- total.eco[,c(1,2)]
total.eco <- total.eco[-12,]
total.eco$class = as.factor("ecology")

# total forestry pubs
total.for <- read_delim("./inst/extdata/bibliometrics/total_forestry_pubs_by_year.txt", delim = "\t")
names(total.for)[1] <- "year"
total.for <- total.for[,c(1,2)]
total.for <- total.for[-12,]
total.for$class = as.factor("forestry")

# merge together
totals <- rbind(total.eco, total.for)

#
big.boi <- merge(df.sums, totals)

big.boi$propR <- big.boi$sum.recs / big.boi$records
big.boi$class <- stringr::str_to_title(big.boi$class)


x11(width = 8, height = 3)
ggplot(big.boi, aes(x = year, y = (propR * 100), color = class))+
  geom_line(size = 2, alpha = 0.6)+
  geom_point(size = 3, shape = 21, fill = "white")+
  theme_minimal()+
  scale_x_continuous(
    labels = scales::number_format(accuracy = 1, big.mark = ""), limits = c(2010, 2019))+
  scale_color_manual(
    name="Journal Class",
    values = c(
      "Ecology" = "#e41a1c",
      "Forestry" ="#377eb8"))+
  theme(legend.position=c(0.02,1), legend.justification=c(0.02,1))+
  xlab("")+
  ylab(expression(atop("Percentage of papers citing R ", paste("in the top 20 journals of each field 2010-2019"))))



