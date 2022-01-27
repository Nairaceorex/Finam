CREATE TABLE User
(
  ID INT NOT NULL AUTO_INCREMENT,
  Full_Name VARCHAR(255) NOT NULL,
  Login VARCHAR(255) NOT NULL,
  Password INT NOT NULL,
  Email VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE (Login)
);

CREATE TABLE Personal_account
(
  ID INT NOT NULL AUTO_INCREMENT,
  Article VARCHAR(255) NOT NULL,
  Number INT NOT NULL,
  Sum INT NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE (Number)
);

CREATE TABLE Operation
(
  ID INT NOT NULL AUTO_INCREMENT,
  Article VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE (Article)
);

CREATE TABLE Personal_Area
(
  ID INT NOT NULL AUTO_INCREMENT,
  Article VARCHAR(255) NOT NULL,
  Number INT NOT NULL,
  Operation_ID INT NOT NULL,
  User_ID INT NOT NULL,
  Personal_Account_ID INT NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (Operation_ID) REFERENCES Operation(ID),
  FOREIGN KEY (User_ID) REFERENCES User(ID),
  FOREIGN KEY (Personal_Account_ID) REFERENCES Personal_account(ID),
  UNIQUE (Number)
);

CREATE TABLE History
(
  ID INT NOT NULL AUTO_INCREMENT,
  Date_Time DATETIME NOT NULL,
  Personal_Area_ID INT,
  PRIMARY KEY (ID),
  FOREIGN KEY (Personal_Area_ID) REFERENCES Personal_Area(ID)
);