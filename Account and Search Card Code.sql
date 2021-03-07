drop table Account

create table Account (
AccountID CHAR(10) NOT NULL,
AccountEmail VARCHAR(30) NOT NULL,
AccountFirstName VARCHAR(20) NOT NULL,
AccountLastName VARCHAR(20) NULL,
AccountPassword VARCHAR(20) NOT NULL,
AccountCurrency INT  NULL,

constraint account_pk primary key (AccountID)
)


create table SearchCard(
AccountID CHAR(10) NOT NULL,
CardID  INT Not NULL,
Quantity INT NULL,

constraint search_pk1 primary key (AccountID,CardID),
constraint search_fk1 foreign key (AccountID) references Account(AccountID),
constraint search_fk2 foreign key (CardID) references Cards(CardID)
)





