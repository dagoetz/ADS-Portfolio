DROP TABLE Sponsorships;
CREATE TABLE Sponsorships(
   CardID        INTEGER  NOT NULL 
  ,SponsorshipID INTEGER  NOT NULL 
  ,Sponsorship   VARCHAR(19) NOT NULL
  ,Brand         VARCHAR(18) NOT NULL

constraint sponsor_pk1 primary key (SponsorshipID,CardID),
constraint sponsor_fk1 foreign key (CardID) references Cards(CardID)
);
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (12376,1,'Diamond Sponsorship','Old Hickory');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (24407,2,'Diamond Sponsorship','Adidas');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (39396,3,'Diamond Sponsorship','Nike');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (96047,4,'Diamond Sponsorship','Louisville Slugger');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (12398,5,'Diamond Sponsorship','Marucci');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (92047,6,'Diamond Sponsorship','Sam Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (99395,7,'Diamond Sponsorship','Under Armour');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (47112,8,'Diamond Sponsorship','Wilson');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (59913,9,'Diamond Sponsorship','Jordan');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (49354,10,'Gold Sponsorship','Lizard Skins');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (45628,11,'Gold Sponsorship','Adidas');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (81815,12,'Gold Sponsorship','New Balance');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (39917,13,'Gold Sponsorship','Trinity Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (19331,14,'Gold Sponsorship','Louisville Slugger');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (64032,15,'Gold Sponsorship','Marucci');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (45283,16,'Gold Sponsorship','Sam Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (28433,17,'Gold Sponsorship','Under Armour');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (39629,18,'Gold Sponsorship','Mizuno');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (73497,19,'Silver Sponsorship','Trinity Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (88381,20,'Silver Sponsorship','Adidas');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (84985,21,'Silver Sponsorship','Lizard Skins');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (70130,22,'Silver Sponsorship','Marucci');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (14042,23,'Silver Sponsorship','Sam Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (69769,24,'Silver Sponsorship','Rawlings');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (77213,25,'Silver Sponsorship','Mizuno');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (95926,26,'Diamond Sponsorship','Lizard Skins');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (31026,27,'Diamond Sponsorship','Trinity');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (28818,28,'Diamond Sponsorship','New Balance');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (27177,29,'Diamond Sponsorship','Rawlings');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (20557,30,'Diamond Sponsorship','Mizuno');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (73409,31,'Diamond Sponsorship','Franklin');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (67587,32,'Diamond Sponsorship','Varo');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (19120,33,'Diamond Sponsorship','SSK');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (33742,34,'Diamond Sponsorship','Axe Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (24940,35,'Gold Sponsorship','Old Hickory');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (16065,36,'Gold Sponsorship','Nike');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (69283,37,'Gold Sponsorship','Rawlings');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (52055,38,'Gold Sponsorship','Franklin');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (88359,39,'Gold Sponsorship','Wilson');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (71230,40,'Gold Sponsorship','STANCE');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (99812,41,'Gold Sponsorship','Varo');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (84822,42,'Silver Sponsorship','New Balance');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (93384,43,'Silver Sponsorship','Old Hickory');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (99911,44,'Silver Sponsorship','Nike');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (53138,45,'Silver Sponsorship','Louisville Slugger');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (46678,46,'Silver Sponsorship','Under Armour');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (81054,47,'Silver Sponsorship','Franklin');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (30942,48,'Silver Sponsorship','Wilson');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (11890,49,'Silver Sponsorship','STANCE');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (49676,50,'Silver Sponsorship','Varo');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (98862,51,'Diamond Sponsorship','All-Star');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (39503,52,'Diamond Sponsorship','EvoShield');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (93550,53,'Diamond Sponsorship','Jordan');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (96873,54,'Diamond Sponsorship','Victus');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (40137,55,'Gold Sponsorship','Axe Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (70372,56,'Gold Sponsorship','SSK');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (84961,57,'Gold Sponsorship','Jordan');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (43104,58,'Gold Sponsorship','All-Star');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (17256,59,'Gold Sponsorship','EvoShield');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (20381,60,'Gold Sponsorship','Victus');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (20376,61,'Silver Sponsorship','Jordan');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (19847,62,'Silver Sponsorship','SSK');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (43994,63,'Silver Sponsorship','Axe Bat');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (13354,64,'Silver Sponsorship','Victus');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (42442,65,'Silver Sponsorship','EvoShield');
INSERT INTO Sponsorships(CardID,SponsorshipID,Sponsorship,Brand) VALUES (15278,66,'Silver Sponsorship','All-Star');
