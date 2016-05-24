getTweets <- function(search_str, n_tweets, lang = NULL , desde=NULL, hasta=NULL){

    library(twitteR)
    library(dplyr)
      
    if(!missing(desde)){
      desde <- as.Date(desde, "%d-%m-%Y")
      desde <- as.character(desde)
    }
    if(!missing(hasta)){
      hasta <- as.Date(hasta, "%d-%m-%Y")
      hasta <- as.character(hasta)
    }
    
    api_key <- "KxsfqNoVT2JmtVo7JT0t4BBbP"
    api_secret <- "4U4PMplHdvlAcZScCRjvZhGcO6fKHE8h96QI9FpKBK4MbuYxOk"
    access_token <- "394549271-B1J5HSypNq6VAUuaS3NUmV8iNUC9vZc1TASSfd5R"
    access_token_secret <- "5G8uAIPi8dbKrkLz49mK1yY3kQhDKAcvYa01TufNFVP6g"
    
    setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
    
    ListaTweets <- searchTwitter(searchString = search_str, n = n_tweets, lang = lang, since = desde, until = hasta)
    
    tweets <- twListToDF(ListaTweets)
    colnames(tweets)[which(names(tweets) == "text")] <- "texto"
    colnames(tweets)[which(names(tweets) == "id")] <- "id"
    colnames(tweets)[which(names(tweets) == "screenName")] <- "nombre"
    colnames(tweets)[which(names(tweets) == "created")] <- "fecha"
    colnames(tweets)[which(names(tweets) == "replyToSN")] <- "respuestaA"
    colnames(tweets)[which(names(tweets) == "replyToSID")] <- "respuestaAid"
    colnames(tweets)[which(names(tweets) == "favorited")] <- "favorito"
    colnames(tweets)[which(names(tweets) == "favoriteCount")] <- "n_favorito"
    colnames(tweets)[which(names(tweets) == "retweeted")] <- "retweeteado"
    colnames(tweets)[which(names(tweets) == "retweetCount")] <- "n_retweet"
    colnames(tweets)[which(names(tweets) == "isRetweet")] <- "es_retweet"
    colnames(tweets)[which(names(tweets) == "statusSource")] <- "fuente"
    colnames(tweets)[which(names(tweets) == "longitude")] <- "longitud"
    colnames(tweets)[which(names(tweets) == "latitude")] <- "latitud"
    
    tweets$truncated <- NULL
    tweets$replyToUID <- NULL
    
    tweetsOrdenados <- tweets
    tweetsOrdenados <- tweetsOrdenados[c(1,7,9,5,4,6,2,3,12,10,11,8,13,14)]
    
    write.table(tweetsOrdenados, file = "01_tweet-retrieving/01_01_retrieve-tweets/datosobtenidos.csv", append = FALSE, quote = TRUE, sep = "\t",
                eol = "\n", na = "NA", dec = ".", row.names = FALSE,
                col.names = TRUE, qmethod = "double",
                fileEncoding = "")
    return(tweetsOrdenados)
}


