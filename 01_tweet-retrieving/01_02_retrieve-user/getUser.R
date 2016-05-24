getUserInfo <- function(user_name, n_followers = 50, n_follows = 50){
    
    library(twitteR)
    library(dplyr)
    library(rjson)
    
    
    api_key <- "KxsfqNoVT2JmtVo7JT0t4BBbP"
    api_secret <- "4U4PMplHdvlAcZScCRjvZhGcO6fKHE8h96QI9FpKBK4MbuYxOk"
    access_token <- "394549271-B1J5HSypNq6VAUuaS3NUmV8iNUC9vZc1TASSfd5R"
    access_token_secret <- "5G8uAIPi8dbKrkLz49mK1yY3kQhDKAcvYa01TufNFVP6g"
    
    setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
    
    user <- getUser(user = user_name)
    df <- user$toDataFrame()
    
    
    colnames(df)[which(names(df) == "name")] <- "nombre"
    colnames(df)[which(names(df) == "id")] <- "id"
    colnames(df)[which(names(df) == "screenName")] <- "nombre_pantalla"
    colnames(df)[which(names(df) == "description")] <- "descripcion"
    colnames(df)[which(names(df) == "statusesCount")] <- "n_tweets"
    colnames(df)[which(names(df) == "followersCount")] <- "n_followers"
    colnames(df)[which(names(df) == "favoritesCount")] <- "n_favorites"
    colnames(df)[which(names(df) == "friendsCount")] <- "n_follows"
    colnames(df)[which(names(df) == "url")] <- "url"
    colnames(df)[which(names(df) == "created")] <- "fecha"
    colnames(df)[which(names(df) == "protected")] <- "protegido"
    colnames(df)[which(names(df) == "verified")] <- "verificado"
    colnames(df)[which(names(df) == "location")] <- "localizacion"
    colnames(df)[which(names(df) == "listedCount")] <- "n_lists"
    colnames(df)[which(names(df) == "profileImageUrl")] <- "imagen_perfil"
    
    df$lang <- NULL
    df$followRequestSent <- NULL
    
    dfOrdenados <- df
    dfOrdenados <- dfOrdenados[c(7, 11, 13, 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 14, 15)]
    
    
    followers <- user$getFollowers()
    followers <- twListToDF(followers)
    
    follows <- user$getFriends()
    follows <- twListToDF(follows)
    
    listaOrdenada <- list(dfOrdenados, follower_ids = row.names(followers)[1:n_followers], follows_ids = row.names(follows)[1:n_follows])
    json <- toJSON(listaOrdenada)
    
    write(json, file = "01_tweet-retrieving/01_02_retrieve-user/datosUser.JSON")
    
    return(json)

}
