## Objet : FEED de la base de données 'thequanticfactory'
## Auteur : Nicolas Mourad
## Date : 26 / 09 / 2022 
## Version: 1.0 

# Import packages
import pandas as pd
import numpy as np
import sqlalchemy

# Load SQL database
engine = sqlalchemy.create_engine('mysql+pymysql://root:root@localhost:3306/thequanticfactory')

# Paramétrage du nombre de contents, de clients et de eventsdata
num_contents = 100
num_clients = 200
num_events = 10000

# Feed table ChannelType
ChannelType = {
    "ChannelTypeID": [1, 2, 3, 4, 5],
    "Name": ["Email", "PhoneNumber", "Postal", "MobileID", "Cookie"]
}
pd.DataFrame(ChannelType).to_sql(name='channeltype', con=engine, index=False, if_exists="append")

# Feed table EventType
EventType = {
    "EventTypeID": [1, 2, 3, 4, 5, 6],
    "Name": ["sent", "view", "click", "visit", "cart", "purchase"]
}
pd.DataFrame(EventType).to_sql(name='eventtype', con=engine, index=False, if_exists="append")

## Feed pour tables Customer et CustomerData, (emails construits ainsi : "customerid" + "@tqf.com")
CustomerID = np.arange(1, num_clients+1)
ClientCustomerID = CustomerID
CustomerChannelID = CustomerID
ChannelTypeID = 1
ChannelValue = [str(id)+"@tqf.com" for id in CustomerID]
InsertDate = pd.date_range("2000-01-01", periods=num_clients)

# Insertion dans la table Customer
Customer = {
    "CustomerID": CustomerID,
    "ClientCustomerID": ClientCustomerID,
    "InsertDate": InsertDate
}
pd.DataFrame(Customer).to_sql(name='customer', con=engine, index=False, if_exists="append")

# Insertion dans la table CustomerData
CustomerData = {
    "CustomerChannelID": CustomerChannelID,
    "CustomerID": CustomerID,
    "ChannelTypeID": ChannelTypeID,
    "ChannelValue": ChannelValue,
    "InsertDate": InsertDate
}
pd.DataFrame(CustomerData).to_sql(name='customerdata', con=engine, index=False, if_exists="append")

## Feed pour tables CustomerEventData, CustomerEvent, Content et ContentPrice 
EventDataID = np.arange(1, num_events+1)
EventID = EventDataID
Contents = np.random.randint(1, num_contents+1, num_events)
Customers = np.random.randint(1, num_clients+1, num_events) # Assign to random customer
EventTypeID = np.random.randint(1, 7, num_events)
EventDate = pd.date_range("2000-01-01", periods=num_events)
Quantity = np.random.randint(1, 10, num_events)

ContentID = np.arange(1, num_contents+1)
Price = np.round(np.random.uniform(1, 100, num_contents), 2)
Currency = "EUR"

# Insertion dans la table Content
Content = {
    "ContentID": ContentID,
    "ClientContentID": ContentID,
    "InsertDate": pd.date_range("2000-01-01", periods=num_contents)
}
pd.DataFrame(Content).to_sql(name='content', con=engine, index=False, if_exists="append")

# Insertion dans la table ContentPrice
ContentPrice = {
    "ContentPriceID": ContentID,
    "ContentID": ContentID,
    "Price": Price,
    "Currency": Currency,
    "InsertDate": pd.date_range("2000-01-01", periods=num_contents)
}
pd.DataFrame(ContentPrice).to_sql(name='contentprice', con=engine, index=False, if_exists="append")

# Insertion dans la table CustomerEvent
CustomerEvent = {
    "EventID": EventID,
    "ClientEventID": EventID,
    "InsertDate": EventDate
}
pd.DataFrame(CustomerEvent).to_sql(name='customerevent', con=engine, index=False, if_exists="append")

# Insertion dans la table CustomerEventData
CustomerEventData = {
    "EventDataID": EventDataID,
    "EventID": EventID,
    "ContentID": Contents,
    "CustomerID": Customers,
    "EventTypeID": EventTypeID,
    "EventDate": EventDate,
    "Quantity": Quantity,
    "InsertDate": EventDate
}
pd.DataFrame(CustomerEventData).to_sql(name='customereventdata', con=engine, index=False, if_exists="append")



