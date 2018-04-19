SPOOL project.out
SET ECHO ON
/*
CIS 353 - Database Design Project
Edric Lin
Emilio Braun
Aaron Bager
*/
--
DROP TABLE Member CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Job CASCADE CONSTRAINTS;
DROP TABLE Department CASCADE CONSTRAINTS;
DROP TABLE Product CASCADE CONSTRAINTS;
DROP TABLE Supplier CASCADE CONSTRAINTS;
DROP TABLE Transaction CASCADE CONSTRAINTS;
DROP TABLE MPhone CASCADE CONSTRAINTS;
DROP TABLE EPhone CASCADE CONSTRAINTS;
DROP TABLE Prod_Trans CASCADE CONSTRAINTS;
--
CREATE TABLE Member
(
mID 		INTEGER,
mFirst 		VARCHAR2(10) 	NOT NULL,
mLast 		VARCHAR2(10) 	NOT NULL,
mAddress 	VARCHAR2(30) 	NOT NULL,
mFee 		INTEGER 	NOT NULL,
mType 		CHAR(1) 	NOT NULL,
a_mID 		INTEGER,
--
CONSTRAINT mIC01 PRIMARY KEY (mid),
CONSTRAINT mIC02 FOREIGN KEY (a_mID) 
	REFERENCES Member(mID)
	ON DELETE SET NULL
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT mIC03 CHECK (mFee = 100 OR mFee = 80),
CONSTRAINT mIC04 CHECK (mType = 'P' OR mType = 'A'),
CONSTRAINT mIC05 CHECK (NOT (mType = 'P' AND NOT (mFee = 100))),
CONSTRAINT mIC06 CHECK (NOT (mType = 'A' AND NOT (mFee = 80)))
);
--
CREATE TABLE Department
(
dID 		INTEGER,
dName 		VARCHAR2(10) 	NOT NULL,
--
CONSTRAINT dIC01 PRIMARY KEY (dID)
);
--
CREATE TABLE Job
(
jID 		INTEGER,
jName 		VARCHAR2(20) 	NOT NULL,
j_dID 		INTEGER,
--
CONSTRAINT jIC01 PRIMARY KEY (jID),
CONSTRAINT jIC02 FOREIGN KEY (j_dID) 
	REFERENCES Department(dID)
	ON DELETE SET NULL
	DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Employee
(
eID 		INTEGER,
eFirst 		VARCHAR2(10) 	NOT NULL,
eLast 		VARCHAR2(10) 	NOT NULL,
eAddress 	VARCHAR2(30) 	NOT NULL,
eSalary 	INTEGER 	NOT NULL,
s_eID 		INTEGER,
e_jID 		INTEGER 	NOT NULL,
--
CONSTRAINT eIC01 PRIMARY KEY (eID),
CONSTRAINT eIC02 FOREIGN KEY (s_eID) 
	REFERENCES Employee(eID)
	ON DELETE SET NULL
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT eIC03 FOREIGN KEY (e_jID) 
	REFERENCES Job(jID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Supplier
(
sID 		INTEGER,
sName 		VARCHAR2(20) 	NOT NULL,
--
CONSTRAINT sIC01 PRIMARY KEY (sid)
);
--
CREATE TABLE Product
(
pID 		INTEGER,
pName 		VARCHAR2(30)	NOT NULL,
pInventory 	INTEGER 	NOT NULL,
pPrice 		NUMBER(5,2) 	NOT NULL,
p_dID 		INTEGER 	NOT NULL,
p_sID 		INTEGER 	NOT NULL,
sDate 		DATE 		NOT NULL,
--
CONSTRAINT pIC01 PRIMARY KEY (pID),
CONSTRAINT pIC02 FOREIGN KEY (p_dID) 
	REFERENCES Department(dID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT pIC03 FOREIGN KEY (p_sID) 
	REFERENCES Supplier(sID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Transaction
(
t_mID 		INTEGER,
tTimestamp 	CHAR(17) 	NOT NULL,
tTotal 		NUMBER(6,2) 	NOT NULL,
--
CONSTRAINT tIC01 PRIMARY KEY (t_mID, tTimestamp),
CONSTRAINT tIC02 FOREIGN KEY (t_mID) 
	REFERENCES Member(mID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT tIC03 CHECK (tTimestamp LIKE '__/__/__ __:__:__')
);
--
CREATE TABLE MPhone
(
m_mID 		INTEGER,
mPhone 		CHAR(14),
--
CONSTRAINT mpIC01 PRIMARY KEY (m_mID, mPhone),
CONSTRAINT mpIC02 FOREIGN KEY (m_mID) 
	REFERENCES Member(mID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT mpIC03 CHECK (mPhone LIKE '(___)-___-____')
);
--
CREATE TABLE EPhone
(
e_mID 		INTEGER,
ePhone 		CHAR(14),
--
CONSTRAINT epIC01 PRIMARY KEY (e_mID, ePhone),
CONSTRAINT epIC02 FOREIGN KEY (e_mID) 
	REFERENCES Member(mID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT epIC03 CHECK (ePhone LIKE '(___)-___-____')
);
--
CREATE TABLE Prod_Trans
(
pt_mID 		INTEGER,
pt_tTimestamp 	CHAR(17),
pt_pID 		INTEGER,
--
CONSTRAINT ptIC01 PRIMARY KEY (pt_mID, pt_tTimestamp, pt_pID),
CONSTRAINT ptIC02 FOREIGN KEY (pt_mID, pt_tTimestamp) 
	REFERENCES Transaction(t_mID, tTimestamp)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT ptIC03 FOREIGN KEY (pt_pID) 
	REFERENCES Product(pID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED
);
--
SET FEEDBACK OFF

INSERT INTO Member VALUES ('10', 'John', 'Smith', '100 address', 100, 'P', 14);
INSERT INTO Member VALUES ('11', 'Logan', 'Gardner', '110 address', 100, 'P', 12);
INSERT INTO Member VALUES ('12', 'Carl', 'Wheeler', '120 address', 80, 'A', NULL);
INSERT INTO Member VALUES ('13', 'Jones', 'Vikema', '130 address', 100, 'P', NULL);
INSERT INTO Member VALUES ('14', 'Gordon', 'Freddrick', '140 address', 80, 'A', NULL);
--
INSERT INTO Department VALUES ('10', 'Salesfloor');
INSERT INTO Department VALUES ('11', 'Checkout');
INSERT INTO Department VALUES ('12', 'Photo');
INSERT INTO Department VALUES ('13', 'Food');
INSERT INTO Department VALUES ('14', 'Pharmacy');
--
INSERT INTO Job VALUES ('10', 'Cashier', '11');
INSERT INTO Job VALUES ('11', 'Chef', '13');
INSERT INTO Job VALUES ('12', 'Sales Associate', '10');
INSERT INTO Job VALUES ('13', 'Photographer', '12');
INSERT INTO Job VALUES ('14', 'Pharmacist', '14');
--
INSERT INTO Employee VALUES ('10', 'Jane', 'Smith', '100 address', '25000', '11', '10');
INSERT INTO Employee VALUES ('11', 'Jill', 'Howard', '110 address', '30000', NULL, '13');
INSERT INTO Employee VALUES ('12', 'Dave', 'Tillman', '120 address', '40000', NULL, '11');
INSERT INTO Employee VALUES ('13', 'Mary', 'Freeman', '130 address', '55000', NULL, '14');
INSERT INTO Employee VALUES ('14', 'Holly', 'North', '100 address', '30000', '10', '12');
--
INSERT INTO Supplier VALUES ('10', 'Gordons Food Service');
INSERT INTO Supplier VALUES ('11', 'Meijers');
INSERT INTO Supplier VALUES ('12', 'Best Buy');
INSERT INTO Supplier VALUES ('13', 'Sparrow Health');
INSERT INTO Supplier VALUES ('14', 'BnH Photo Video');
--
INSERT INTO Product VALUES ('10', 'Charmins Toilet Paper', 100, 5.00, '10', '11', TO_DATE('10/10/18', 'MM/DD/YY')); 
INSERT INTO Product VALUES ('11', 'Ramon Noodle Soup', 50, 2.00, '10', '10', TO_DATE('10/10/18', 'MM/DD/YY')); 
INSERT INTO Product VALUES ('12', 'Light Bulbs (4 pck.)', 40, 10.00, '10', '11', TO_DATE('10/10/18', 'MM/DD/YY')); 
INSERT INTO Product VALUES ('13', 'Asus Laptop', 20, 500.00, '10', '12', TO_DATE('10/10/18', 'MM/DD/YY')); 
INSERT INTO Product VALUES ('14', 'Fresh Chicken Roast', 30, 5.00, '13', '10', TO_DATE('10/10/18', 'MM/DD/YY')); 
--
INSERT INTO Transaction VALUES ('10', '10/12/18 08:12:50', 10);
INSERT INTO Transaction VALUES ('11', '10/12/18 09:00:21', 40);
INSERT INTO Transaction VALUES ('12', '10/12/18 10:14:03', 20);
INSERT INTO Transaction VALUES ('13', '10/12/18 10:53:42', 15);
INSERT INTO Transaction VALUES ('14', '10/12/18 12:38:12', 5);
--
INSERT INTO MPhone VALUES ('10', '(616)-100-1212');
INSERT INTO MPhone VALUES ('11', '(616)-110-1212');
INSERT INTO MPhone VALUES ('12', '(616)-120-1212');
INSERT INTO MPhone VALUES ('13', '(616)-130-1212');
INSERT INTO MPhone VALUES ('14', '(616)-140-1212');
--
INSERT INTO EPhone VALUES ('10', '(616)-000-0000');
INSERT INTO EPhone VALUES ('11', '(616)-001-0101');
INSERT INTO EPhone VALUES ('12', '(616)-002-0202');
INSERT INTO EPhone VALUES ('13', '(616)-003-0303');
INSERT INTO EPhone VALUES ('14', '(616)-004-0404');
--
INSERT INTO Prod_Trans VALUES ('10', '10/12/18 08:12:50', '10');
INSERT INTO Prod_Trans VALUES ('11', '10/12/18 09:00:21', '11');
INSERT INTO Prod_Trans VALUES ('12', '10/12/18 10:14:03', '12');
INSERT INTO Prod_Trans VALUES ('13', '10/12/18 10:53:42', '13');
INSERT INTO Prod_Trans VALUES ('14', '10/12/18 12:38:12', '14');

SET FEEDBACK ON
COMMIT;
--
< One query (per table) of the form: SELECT * FROM table; in order to print out your
database >
--
< The SQL queries>. Include the following for each query:
1. A comment line stating the query number and the feature(s) it demonstrates
(e.g. – Q25 – correlated subquery).
2. A comment line stating the query in English.
3. The SQL code for the query.
--
< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs to test).
? A comment line stating: Testing: < IC name>
? A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF
