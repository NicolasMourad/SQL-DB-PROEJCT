## Objet : déterminer les meilleurs clients d'une boutique E-Commerce répartis par quantiles
## Auteur : Nicolas Mourad
## Date : 27 / 09 / 2022 
## Version: 1.0 

# Import packages
import pandas as pd
import numpy as np
import sqlalchemy
from datetime import date

# Load SQL database
engine = sqlalchemy.create_engine('mysql+pymysql://root:root@localhost:3306/thequanticfactory')

## 1- Déterminer le chiffre d'affaire (CA) par client
# Création de la map (view) du chiffre total par clients depuis le 01/04/2020
engine.execute("CREATE OR REPLACE VIEW CA_PAR_CLIENTS AS SELECT customerID, SUM(quantity*price) as CA FROM customereventdata AS CED, contentprice AS CP WHERE CED.InsertDate >'2020-04-01' AND CED.ContentID = CP.ContentID AND  EventTypeID = 6 GROUP BY CustomerID ORDER BY CA DESC")

# Print dans le log les 10 entrées de cette map
print ("Meilleurs clients par chiffre d'affaire:")
engine.execute("SELECT * from CA_PAR_CLIENTS LIMIT 10").fetchall()
## 1 - FIN

## 2- TOP CUSTOMER PAR QUANTILES 
# Création de la view de répartition par quantiles
engine.execute("CREATE OR REPLACE VIEW CA_PAR_QUANTILES as SELECT NTILE(40) OVER (ORDER BY CA DESC) quant, customerid, CA from CA_PAR_CLIENTS")

# Création de la map avec les clients du 1er quantile
engine.execute("CREATE OR REPLACE VIEW TOP_CLIENTS_QUANTILE1 as SELECT * FROM CA_PAR_QUANTILES WHERE quant = 1")

# Nombre de clients pour le 1er quantile
print("Nombre de Clients pour le 1er Quantile:")
engine.execute("SELECT COUNT(*) from TOP_CLIENTS_QUANTILE1").fetchall()

# Création d'une MAP quantiles par quantiles du CA avec nombre de clients par quantiles, CA MAX, CA MIN
print("Map clients par quantiles:")
engine.execute("CREATE OR REPLACE VIEW MAP_QUANTILE as SELECT quant,COUNT(customerid), MAX(CA), MIN(CA) FROM CA_PAR_QUANTILES GROUP BY quant")
## 2- FIN 

## 3- EXPORT
# Création de la table si elle n'existe pas "test_export_YYYYMMDD"
engine.execute("CREATE TABLE IF NOT EXISTS test_export_" + date.today().strftime("%Y%m%d") + " (customerid bigint, email varchar(600), CA decimal(8,2), PRIMARY KEY (customerid))")

# Création de la view avant insertion dans la table
engine.execute("CREATE OR REPLACE VIEW test_export_ AS SELECT cpc.customerID, ChannelValue as email, CA FROM CA_PAR_CLIENTS as CPC, customerdata AS CD WHERE CPC.CustomerID = CD.CustomerID AND CD.ChannelTypeID = '1'")

engine.execute("REPLACE INTO test_export_" + date.today().strftime("%Y%m%d") + " SELECT * FROM test_export_")
## 3- FIN
