DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS CustAdress;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS usingNow;
DROP TABLE IF EXISTS Supplements;
DROP TABLE IF EXISTS canBuy;
DROP TABLE IF EXISTS Membership;
DROP TABLE IF EXISTS Standard;
DROP TABLE IF EXISTS Platinum;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS EmplAdress;
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Has;

CREATE TABLE Customer(
    id INTEGER PRIMARY KEY,
    birthDate DATE NOT NULL,
    name VARCHAR(50) NOT NULL,
    mobile VARCHAR(13) NOT NULL,
    email VARCHAR(60) NOT NULL,
  
  CONSTRAINT custEmail CHECK (email LIKE '%_@_%.__%')
);

INSERT INTO Customer VALUES (1, "1997-1-1", "Karel", "45", "david.herel@seznam.cz");
INSERT INTO Customer VALUES (2, "2000-1-1", "Despou", "45", "david.herel@seznam.cz");
INSERT INTO Customer VALUES (3, "2000-1-1", "ŠPEK", "45", "david.herel@seznam.cz");

CREATE TABLE CustAdress(
    customer INTEGER NOT NULL REFERENCES Customer(id),
    number VARCHAR(40) NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(90) NOT NULL,
    
    PRIMARY KEY(customer, number, street, city)
);

INSERT INTO CustAdress VALUES (1, "1", "Namesti", "Praha");
INSERT INTO CustAdress VALUES (2, "565", "Ulice", "Jaromer");

CREATE TABLE Equipment(
    serialNumber INTEGER PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE usingNow(
    equipment INTEGER PRIMARY KEY,
    customer INTEGER NOT NULL REFERENCES Customer(id),
    length INTEGER NOT NULL,
    
    UNIQUE(customer),
    CONSTRAINT equipmentFK FOREIGN KEY (equipment) REFERENCES Equipment(serialNumber)

);
INSERT INTO Equipment VALUES(1, "Benchpress", "new");
INSERT INTO Equipment VALUES(2, "Klec", "new");
INSERT INTO usingNow VALUES(1, 1, 20);
INSERT INTO usingNow VALUES(2, 2, 40);

CREATE TABLE Supplements(
    name VARCHAR(60) NOT NULL,
    calories INTEGER NOT NULL,
    cost DECIMAL(8, 2) NOT NULL,
    
    PRIMARY KEY(name)
);

CREATE TABLE canBuy(
    name VARCHAR(60) NOT NULL REFERENCES Supplements(name),
    customerId INTEGER NOT NULL REFERENCES Customer(id),
    
    PRIMARY KEY(name, customerId)
);

CREATE TABLE Membership(
    customer INTEGER NOT NULL REFERENCES Customer(id),
    endDate DATE NOT NULL,
    startDate DATE NOT NULL,
    cost DECIMAL(8, 2) NOT NULL,
  
    CONSTRAINT dates CHECK(endDate > startDate),
    
    PRIMARY KEY(customer, endDate)
);

CREATE TABLE Standard(
    customer INTEGER NOT NULL,
    endDate DATE NOT NULL,
    standardCard boolean DEFAULT TRUE  NOT NULL,
    
    CONSTRAINT StandardFK FOREIGN KEY (customer, endDate) REFERENCES Membership(customer, endDate),
    PRIMARY KEY(customer, endDate)
);

CREATE TABLE Platinum(
    customer INTEGER NOT NULL,
    endDate DATE NOT NULL,
    platinumCard boolean DEFAULT TRUE NOT NULL ,
    
    CONSTRAINT PlatinumFK FOREIGN KEY (customer, endDate) REFERENCES Membership(customer, endDate),
    PRIMARY KEY(customer, endDate)
);

INSERT INTO Membership VALUES(1,"2019-11-1", "2019-1-4",400);
INSERT INTO Membership VALUES(2,"2015-11-1", "2017-1-4",400);

CREATE TABLE Classes(
    name VARCHAR(60) NOT NULL,
    length INTEGER NOT NULL,
    datum DATE NOT NULL,
    classCode INTEGER  NOT NULL UNIQUE,
    cost DECIMAL(8, 2) NOT NULL,
    
    PRIMARY KEY(name, length, datum)
    
);

CREATE TABLE Employee(
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    mobile VARCHAR(13) NOT NULL,
    wage DECIMAL(8, 2) NOT NULL,
    email VARCHAR(60) NOT NULL,
  
  CONSTRAINT emplEmail CHECK (email LIKE '%_@_%.__%') 
);

INSERT INTO Employee VALUES(1, "Honza", "123", 32000, "david.herel@seznam.cz");
INSERT INTO Employee VALUES(2, "Luk", "123", 25000, "david.herel@seznam.cz");

CREATE TABLE EmplAdress(
    employee INTEGER NOT NULL REFERENCES Employee(id),
    number VARCHAR(40) NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(90) NOT NULL,
    
    PRIMARY KEY(employee, number, street, city)
);

CREATE TABLE Manager(
    employee INTEGER NOT NULL REFERENCES Employee(id),
    manager INTEGER NOT NULL REFERENCES Employee(id),
    
    PRIMARY KEY(employee, manager)
);

CREATE TABLE Has(
    customer INTEGER NOT NULL REFERENCES Customer(id),
    name VARCHAR(50) NOT NULL,
    length INTEGER NOT NULL,
    datum DATE NOT NULL,
    employee INTEGER NOT NULL REFERENCES Employee(id),
    
    PRIMARY KEY(customer),
    UNIQUE(name, length, datum, employee),
    CONSTRAINT classesFK FOREIGN KEY (name, length, datum) REFERENCES Classes(name, length, datum)    
);
