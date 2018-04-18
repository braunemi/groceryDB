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

CONSTRAINT mIC3 CHECK ((mType IS 'primary' AND mFee == 100) || (mType IS'affiliate' AND mFee == 80)) 
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
		DEFERRABLE INITIALLY DEFERRED
);
---------------------
CREATE TABLE Jobs (
jID	   INTEGER,
jName	   CHAR(15)	NOT NULL,
j_dID	   INTEGER	NOT NULL,
--
CONSTRAINT jIC1 PRIMARY KEY (jID),

CONSTRAINT jIC2 FOREIGN KEY (j_dID) REFERENCES Department (dID)
		ON DELETE SET NULL
		DEFERRABLE INITIALLY DEFERRED
);

);
---------------------
CREATE TABLE Departments (
dID	   INTEGER,
dName	   CHAR(15)	NOT NULL,
--
CONSTRAINT dIC1 PRIMARY KEY (dID)
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

CONSTRAINT pIC2 FOREIGN KEY (p_dID) REFERENCES Department (dID)
		ON DELETE SET NULL
		DEFERRABLE INITIALLY DEFERRED,

CONSTRAINT pIC3 FOREIGN KEY (p_sID) REFERENCES Suppliers (sID)
		ON DELETE SET NULL
		DEFERRABLE INITIALLY DEFERRED
);
--------------------
CREATE TABLE Suppliers (
sID	   INTEGER,
sName	   CHAR(15)	NOT NULL,
--
CONSTRAINT sIC1 PRIMARY KEY (sID)
);
--------------------
CREATE TABLE Transactions (
t_mID	   INTEGER,
tTimestamp CHAR(18),
tTotal	   INTEGER	NOT NULL,
--
CONSTRAINT tIC1 PRIMARY KEY (t_mID, tTimestamp)
);
--------------------
CREATE TABLE mPhone (
m_mID	   INTEGER,
mPhone	   CHAR(11),
--
CONSTRAINT mpIC1 PRIMARY KEY (m_mID, mPhone)
);
--------------------
CREATE TABLE ePhone (
e_eID	   INTEGER,
ePhone	   CHAR(11),
--
CONSTRAINT epIC1 PRIMARY KEY (e_eID, ePhone)
);
--------------------
CREATE TABLE prod_Trans (
pt_mID	   INTEGER,
pt_tTimestamp CHAR(18),
pt_pID	   INTEGER,
--
CONSTRAINT ptIC1 PRIMARY KEY (pt_mID, pt_tTimestamp, pt_pID)
);
--
--------------------
SET FEEDBACK OFF

