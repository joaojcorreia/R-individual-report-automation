library(tidyverse)
library(palmerpenguins) #load palmer penguins dataset
library(randomNames) #load random names package to name the penguins#

#prepare full dataset#

full_data <- penguins %>% 
  drop_na() %>% 
  mutate(
    sex.2 = case_when(sex == "male" ~ 0, sex == "female" ~ 1)) %>% 
      mutate( name = randomNames(name.order='first.last', name.sep=' ', gender = sex.2)) %>% 
  select(-c('year','sex.2')) %>% 
  slice(c(1:10,100:110,200:205,300:305))
  
#create a title vector for graphs#

title_vect <- c("Bill lenght", "Bill depth", "Flipper lenght" ,"Weight")

#create a legend vector for graphs#

legend_vect <- c("mm", "mm", "mm" ,"g")

#select individual and create new full data without individual#

select.individual <- function(a){
  
  ind_data <<- full_data[a,] #individual dataset#
  
  full_data_2 <<- full_data[-a,] #new full_data without the individual#
  
}

# Function to plot the graph #

plot.graph <- function(b){

  
  full_data_2 %>% 
    select(c(1,2+b,7)) %>% 
    mutate(species = str_replace_all(species, as.character(ind_data$species), "My species")) %>% 
    mutate(species = str_replace_all(species, "^(?!My species).*", "Other penguins")) %>% 
    `names<-`(replace(names(.), 2, "data")) %>%
    mutate(species = factor(species , levels=c("Other penguins", "My species"))) %>% 
      ggplot(aes(x=data, y=species, fill=sex ))+
        geom_violin(trim=FALSE)+
        scale_fill_brewer(palette="Blues", labels=c("\u2642", "\u2640"))+
        geom_vline(aes(xintercept=as.numeric(ind_data[,2+b])),
               linetype=2, linewidth=0.5)+ #vertical line with my data#
        geom_text(aes(as.numeric(ind_data[,2+b]),0.5),label = "Me" , size = 3, 
                  vjust = -0.5 ,angle = 90)+ #label with my label#
        theme_minimal()+
        xlab(as.character(legend_vect[b]))+
        ggtitle(as.character(title_vect[b]))+
        theme(axis.text.y =element_text(angle=90, hjust=0.5),
              axis.title.y = element_blank(),
              plot.title = element_text(hjust = 0.5),
              legend.title = element_blank(),
              aspect.ratio=2/5)
      
}
      
