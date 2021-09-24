## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------
#knitr::opts_chunk$set(echo = TRUE)
#knitr::opts_chunk$set(comment=NA)

rm(list=ls())
## --------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(rvest)


## --------------------------------------------------------------------------------------------------------------------------------
webpage <- read_html("https://www.ssb.no/a/histstat/aarbok/ht-0901-bnp.html")
tabell <- html_table(html_nodes(webpage, "table")[[2]])

names(tabell)[1] <- c("År")

tabell <- as_tibble(tabell)
tabell

## --------------------------------------------------------------------------------------------------------------------------------
#head(tabell)
#tail(tabell)
#str(tabell)
#names(tabell)

names(tabell)
library(janitor)

tabell <- clean_names(tabell)


## --------------------------------------------------------------------------------------------------------------------------------
tabell <- tabell %>% drop_na()

## --------------------------------------------------------------------------------------------------------------------------------
#names(tabell) <- c("År", "BNP", "BNP_endring",
#                   "BNP_percap", "BNP_percap_endring")

## --------------------------------------------------------------------------------------------------------------------------------
tabell <-
  tabell %>% 
  mutate(BNP=str_replace_all(BNP, " ", ""), # erstatter vi mellomrom som tusenskilletegn
         BNP_endring=na_if(BNP_endring, ""), #  tomme tegn ("“) for endringene med manglende observasjon (NA)
         BNP_percap_endring=na_if(BNP_percap_endring, ""),
         BNP_endring=str_replace(BNP_endring, ",","."), # erstatter , som desimalskilletegn med .
         BNP_percap_endring=str_replace(BNP_percap_endring, ",",".")) %>% 
  mutate_if(is.character, as.numeric)

tabell


## ----echo=TRUE, eval=FALSE-------------------------------------------------------------------------------------------------------
## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------
#knitr::opts_chunk$set(echo = TRUE)
#knitr::opts_chunk$set(comment=NA)


