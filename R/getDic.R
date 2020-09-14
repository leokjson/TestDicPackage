
get_dic <- function(dic_name){

  dic_path <- file.path(system.file(package='NIADic2'), "hangul.db")
  conn <- dbConnect(SQLite(), dic_path)
  on.exit({dbDisconnect(conn)})
  if(!(dic_name %in% dbListTables(conn))){
    stop(sprintf("NIADic does not contain '%s' dictionary!", dic_name))
  }
  dic <- dbGetQuery(conn, sprintf("select * from %s", dic_name))
  Encoding(dic$term) <- 'UTF-8'
  if(dic_name == 'woorimalsam'){
    Encoding(dic$category) <- 'UTF-8'
  }
  return(dic)
}


