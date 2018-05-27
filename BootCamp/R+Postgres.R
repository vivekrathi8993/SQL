install.packages('RPostgreSQL')

library(RPostgreSQL)

drv <- dbDriver('PostgreSQL')  
db <- 'bootcamp'  
host_db <- 'localhost'  
db_port <- '5432'  
db_user <- 'postgres'  
db_password <- "Password@1"

conn<-dbConnect(drv,dbname=db,host=host_db,
                port=db_port,user=db_user,
                password=db_password)

dbListTables(conn)

dbReadTable(conn,"sales")


avg_by_promo <- dbGetQuery(conn,"SELECT round(AVG(quantity),2) as avg_sales,promo_description
from sales inner join promo on sales.promo_code=promo.promo_code group by promo_description")

avg_by_promo2 <- dbGetQuery(conn,"SELECT round(AVG(quantity),2) as avg_sales,
                                  promo_description
                                  from sales
                                  inner join promo on 
                                  sales.promo_code=promo.promo_code group by promo_description")

library(ggplot2)

ggplot(avg_by_promo,aes(x=promo_description,y=avg_sales,fill=promo_description))+
  geom_col()