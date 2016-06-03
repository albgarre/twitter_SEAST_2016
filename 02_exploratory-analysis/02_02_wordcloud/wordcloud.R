library(tm)
library(wordcloud)
library(dplyr)

##Tweets El Clasico
clasico_tweets <- read.table(file = "data/ElClasico_tweets.csv",
                     header = TRUE,
                     sep = "\t",
                     stringsAsFactors = FALSE)

clasico_corpus <- Corpus(VectorSource(clasico_tweets$texto)) %>%
  tm_map(., removePunctuation) %>%
  tm_map(., removeNumbers) %>%
  tm_map(., stripWhitespace) %>%
  tm_map(., content_transformer(tolower)) %>%
  tm_map(., removeWords, stopwords("spanish"))

wordcloud(clasico_corpus, 
          scale=c(5,0.5), 
          max.words=100, 
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8,"Dark2"))


##Tweets Donald Trump
trump_tweets <- read.table(file = "data/Trump_tweets.csv",
                         header = TRUE,
                         sep = "\t",
                         stringsAsFactors = FALSE)

trump_corpus <- Corpus(VectorSource(trump_tweets$texto)) %>%
  tm_map(., removePunctuation) %>%
  tm_map(., removeNumbers) %>%
  tm_map(., stripWhitespace) %>%
  tm_map(., content_transformer(tolower)) %>%
  tm_map(., removeWords, stopwords("english"))

wordcloud(trump_corpus, 
          scale=c(5,0.5), 
          max.words=100, 
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8,"Dark2"))

##Tweets GoT (datos del trabajo de Alex)
got_tweets <- read.table(file = "data/Tweets_GoT.csv",
                           header = TRUE,
                           sep = "\t",
                           stringsAsFactors = FALSE)

got_corpus <- Corpus(VectorSource(got_tweets$texto)) %>%
  tm_map(., removePunctuation) %>%
  tm_map(., removeNumbers) %>%
  tm_map(., stripWhitespace) %>%
  tm_map(., content_transformer(tolower)) %>%
  tm_map(., removeWords, stopwords("english"))

wordcloud(got_corpus, 
          scale=c(5,0.5), 
          max.words=100, 
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8,"Dark2"))

##Tweets Master Chef (datos del trabajo de Alex)
masterchef_tweets <- read.table(file = "data/masterchef.csv",
                         header = TRUE,
                         sep = "\t",
                         stringsAsFactors = FALSE)

masterchef_corpus <- Corpus(VectorSource(masterchef_tweets$texto)) %>%
  tm_map(., removePunctuation) %>%
  tm_map(., removeNumbers) %>%
  tm_map(., stripWhitespace) %>%
  tm_map(., content_transformer(tolower)) %>%
  tm_map(., removeWords, stopwords("spanish"))

wordcloud(masterchef_corpus, 
          scale=c(5,0.5), 
          max.words=100, 
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8,"Dark2"))

##Tweets Día de la Mujer (datos del trabajo de Alex)
diamujer_tweets <- read.table(file = "data/diamujer.csv",
                                header = TRUE,
                                sep = "\t",
                                stringsAsFactors = FALSE)

diamujer_corpus <- Corpus(VectorSource(diamujer_tweets$texto)) %>%
  tm_map(., removePunctuation) %>%
  tm_map(., removeNumbers) %>%
  tm_map(., stripWhitespace) %>%
  tm_map(., content_transformer(tolower)) %>%
  tm_map(., removeWords, stopwords("spanish"))

wordcloud(diamujer_corpus, 
          scale=c(5,0.5), 
          max.words=100, 
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8,"Dark2"))

