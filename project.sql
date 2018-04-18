SPOOL project.out
SET ECHO ON
/*
CIS 353 - Database Design Project
<Emilio Braun>
<Edric Lin>
<Aaron Bager>
*/
-- Creating the tables
- _-------------------
CREATE TABLE Members (
mID	   INTEGER,
mFirst 	   CHAR(15)	NOT NULL,
mLast 	   CHAR(15)	NOT NULL,
mAddress   CHAR(30)	NOT NULL,
mFee	   INTEGER	NOT NULL,
mType	   CHAR(10)	NOT NULL,
a_mID	   INTEGER,
--
CONSTRAINT mIC1 PRIMARY KEY (mID),

CONSTRAINT mIC2 CHECK (mType IN ('primary', 'affiliate')),

CONSTRAINT mIC3 CHECK ((mType IS 'primary' AND mFee == 100) || (mType IS'affiliate' AND mFee == 80)), 
);
---------------------
CREATE TABLE Employee (
eID	   INTEGER,
eFirst 	   CHAR(15)	NOT NULL,
eLast 	   CHAR(15)	NOT NULL,
eAddress   CHAR(30)	NOT NULL,
eSalary    INTEGER	NOT NULL,
s_eID	   INTEGER, 
e_jID	   INTEGER	NOT NULL,
--
CONSTRAINT eIC1 PRIMARY KEY (eID),

CONSTRAINT eIC2 FOREIGN KEY (s_eID) REFERENCES Employee (eID)
		ON DELETE SET NULL
		DEFERRABLE INITIALLY DEFERRED,

CONSTRAINT eIC3 FOREIGN KEY (e_jID) REFERENCES Jobs (jID)
		ON DELETE SET NULL
		DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT eIC4   

);
---------------------
CREATE TABLE Jobs (
jID	   INTEGER,
jName	   CHAR(15)	NOT NULL,
j_dID	   INTEGER	NOT NULL,
--
CONSTRAINT jIC1 PRIMARY KEY (jID),

CONSTRAINT jIC2 

);
---------------------
CREATE TABLE Departments (
dID	   INTEGER,
dName	   CHAR(15)	NOT NULL,
--
CONSTRAINT dIC1 PRIMARY KEY (dID),

CONSTRAINT dIC2

);
--------------------	
CREATE TABLE Products (
pID	   INTEGER,
pName	   CHAR(15)	NOT NULL,
pInventory INTEGER	NOT NULL,
pPrice	   INTEGER	NOT NULL,
p_dID	   INTEGER	NOT NULL,
p_sID	   INTEGER	NOT NULL,
sDate	   CHAR(15)	NOT NULL,
--
CONSTRAINT pIC1 PRIMARY KEY (pID),

CONSTRAINT pIC2 

);
--------------------
CREATE TABLE Suppliers (
sID	   INTEGER,
sName	   CHAR(15)	NOT NULL,
--
CONSTRAINT sIC1 PRIMARY KEY (sID),

CONSTRAINT sIC2

);
--------------------
CREATE TABLE Transactions (
t_mID	   INTEGER,
tTimestamp INTEGER,
tTotal	   INTEGER	NOT NULL,
--
CONSTRAINT tIC1 PRIMARY KEY (t_mID, tTimestamp),

CONSTRAINT tIC2

);
--------------------
CREATE TABLE mPhone (
m_mID	   INTEGER,
mPhone	   CHAR(15),
--
CONSTRAINT mpIC1 PRIMARY KEY (m_mID, mPhone),

CONSTRAINT mpIC2

);
--------------------
CREATE TABLE ePhone (
e_eID	   INTEGER,
ePhone	   CHAR(15),
--
CONSTRAINT epIC1 PRIMARY KEY (e_eID, ePhone),

CONSTRAINT epIC2

);
--------------------
CREATE TABLE prod_Trans (
pt_mID	   INTEGER,
pt_tTimestamp CHAR(15),
pt_pID	   INTEGER,
--
CONSTRAINT ptIC1 PRIMARY KEY (pt_mID, pt_tTimestamp, pt_pID),

CONSTRAINT ptIC2

);
