library(RPostgres)

##connect wrds
wrds <- dbConnect(Postgres(),
                 host='wrds-pgdata.wharton.upenn.edu',
                 port=9737,
                 dbname='wrds',
                 sslmode='require',
                 user="mqjhan",
                 password="mqjhan@PhDclass")
##get schema names from wrds
res <- dbSendQuery(wrds, "select distinct table_schema
                   from information_schema.tables
                   order by table_schema")
schemas <- dbFetch(res, n=-1)
schemas
dbClearResult(res)

####get table names form compustat
res <- dbSendQuery(wrds, "select table_name
                   from information_schema.tables
                   where table_schema='comp'")
tables <- dbFetch(res, n=-1)
tables
dbClearResult(res)

####get varaible names form a table
res <- dbSendQuery(wrds, "select column_name
                   from information_schema.columns
                  where table_schema='comp'
                   and table_name='company'
                   order by column_name")
varaibles <- dbFetch(res, n=-1)
dbClearResult(res)
varaibles

## customize a dataset
res <- dbSendQuery(wrds, "select a.gvkey,a.fyear,
                   a.at,a.sale,b.sic,b.state
                   from comp.funda a join comp.company b
                   on a.gvkey=b.gvkey
                   where a.consol='C'
                   and a.datafmt='STD'
                   and a.popsrc='D'
                   and a.at>0
                   and a.sale>0
                   and a.fyear between 2010 and 2012")
compfunda=dbFetch(res,n=-1)
dbClearResult(res)

##crsp example
res <- dbSendQuery(wrds, "select a.permno,a.date,a.ret,b.vwretd
                   from crsp.dsf a join crsp.dsi b
                   on a.date=b.date
                   where a.date between '2013-01-07'
                   and '2013-02-07'")
stockdata <- dbFetch(res, n=-1)
dbClearResult(res)
stockdata

