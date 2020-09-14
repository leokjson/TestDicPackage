

.NIADicEnv <- new.env()


#' @importFrom RSQLite dbConnect dbWriteTable dbDisconnect SQLite
.onAttach <- function(libname, pkgname){
  han_db_path <- file.path(system.file(package=pkgname), "hangul.db")
  dic_rda_path <- file.path(system.file(package=pkgname), "dics.RData")
  if(!file.exists(han_db_path)){
    load(dic_rda_path, envir=.NIADicEnv)
    #make database
    conn <- dbConnect(SQLite(), han_db_path)
    on.exit({dbDisconnect(conn)})
    packageStartupMessage("Building dictionary database...")
    dbWriteTable(conn,"woorimalsam",  get("woorimalsam", envir=.NIADicEnv))
    dbWriteTable(conn,"insighter",    get("insighter", envir=.NIADicEnv))
    dbWriteTable(conn,"sejong", get("sejong", envir=.NIADicEnv))
    rm(list=c('woorimalsam', 'insighter', 'sejong'),envir = .NIADicEnv)
    if( all(c('woorimalsam', 'insighter', 'sejong') %in% dbListTables(conn)) ){
      packageStartupMessage("Database building completed.")
    }else{
      stop("Building dictionary database was failed.")
    }
  }

  assign("dic_rda_path", dic_rda_path, .NIADicEnv)
  assign("hangul_db_path", han_db_path, .NIADicEnv)
  packageStartupMessage("Successfully Loaded NIADic Package.")
}


