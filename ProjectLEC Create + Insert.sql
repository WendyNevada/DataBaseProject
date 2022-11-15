CREATE DATABASE projectlec
USE projectlec

CREATE TABLE Employee_Position(
	Employee_PositionID CHAR(5) PRIMARY KEY CHECK(Employee_PositionID LIKE 'PO[0-9][0-9][0-9]'),
	Position VARCHAR(15) CHECK (Position IN('Chef','Manager','Staff')) NOT NULL
)
DROP TABLE Employee_Position

INSERT INTO Employee_Position VALUES
('PO001','Manager'),
('PO002','Chef'),
('PO003','Staff')

SELECT * FROM Employee_Position

CREATE TABLE Ms_Employee(
	ID_Karyawan CHAR(5) PRIMARY KEY CHECK (ID_Karyawan LIKE 'EP[0-9][0-9][0-9]'),
	Nama_Karyawan VARCHAR(25) NOT NULL,
	Email_Karyawan VARCHAR(30) CHECK (Email_Karyawan LIKE '%@gmail.com' OR Email_Karyawan LIKE '%@yahoo.com') NOT NULL,
	NoHp_Karyawan VARCHAR(15) NOT NULL,
	Employee_PositionID CHAR(5) FOREIGN KEY REFERENCES Employee_Position(Employee_PositionID) CHECK(Employee_PositionID LIKE 'PO[0-9][0-9][0-9]') 
)
DROP TABLE Ms_Employee

INSERT INTO Ms_Employee VALUES
('EP001','Budi','Budi@gmail.com','08154321123','PO001'),
('EP002','Adi','Adi@gmail.com','08152354679','PO002'),
('EP003','Susi','Susi@yahoo.com','08157158972','PO002'),
('EP004','Kevin','Kevin@gmail.com','08137562093','PO003'),
('EP005','Angel','Angel@yahoo.com','08150978900','PO003')

SELECT * FROM Ms_Employee

CREATE TABLE Ms_Customer(
	ID_Pelanggan CHAR(5) PRIMARY KEY CHECK(ID_Pelanggan LIKE 'CM[0-9][0-9][0-9]'),
	Nama_Pelanggan VARCHAR(30) NOT NULL,
	Email_Pelanggan VARCHAR(50) CHECK(Email_Pelanggan LIKE '%@gmail.com' OR Email_Pelanggan LIKE '%@yahoo.com') NOT NULL,
	NoHP_Pelanggan VARCHAR(15) NOT NULL
)
DROP TABLE Ms_Customer

INSERT INTO Ms_Customer VALUES
('CM001','Aman','Aman@gmail.com','08123456789'),
('CM002','Rudal','RudalPenyok@yahoo.com','08123456710'),
('CM003','Rudi','Rudi123@gmail.com','08123456711'),
('CM004','Jaka','JakaTingkir@yahoo.com','081234567812'),
('CM005','Ayu','Ayu_Tenan@gmail.com','081234567813')

SELECT * FROM Ms_Customer

CREATE TABLE Payment_Type(
	Payment_TypeID CHAR(5) PRIMARY KEY CHECK(Payment_TypeID LIKE 'TY[0-9][0-9][0-9]'),
	Payment_Type VARCHAR(10) NOT NULL
)

INSERT INTO Payment_Type VALUES
('TY001','Cash'),
('TY002','Credit'),
('TY003','Gopay'),
('TY004','DANA'),
('TY005','OVO')

SELECT * FROM Payment_Type

CREATE TABLE Receipt(
	Receipt_Number CHAR(10) PRIMARY KEY CHECK( Receipt_Number LIKE '[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'),
	ID_Pelanggan CHAR(5) FOREIGN KEY REFERENCES Ms_Customer(ID_Pelanggan) CHECK(ID_Pelanggan LIKE 'CM[0-9][0-9][0-9]') NOT NULL,
	ID_Karyawan CHAR(5) FOREIGN KEY REFERENCES Ms_Employee(ID_Karyawan) CHECK(ID_Karyawan LIKE 'EP[0-9][0-9][0-9]') NOT NULL,
	Payment_TypeID CHAR(5) FOREIGN KEY REFERENCES Payment_Type(Payment_TypeID) CHECK(Payment_TypeID LIKE 'TY[0-9][0-9][0-9]') NOT NULL,
	Receipt_Date DATE NOT NULL,
	Total_Payment INT NOT NULL
)
DROP TABLE Receipt

INSERT INTO Receipt VALUES
('AAAAAA0001','CM001','EP004','TY001','2021-06-15','12000'),
('AAAAAB0012','CM002','EP005','TY002','2021-06-15','14000'),
('AAAABC0123','CM003','EP005','TY003','2021-06-15','30000'),
('AAABCD1234','CM004','EP004','TY004','2021-06-16','35000'),
('AABCDE2345','CM005','EP005','TY005','2021-06-16','28000')

SELECT * FROM Receipt

CREATE TABLE Menu(
	Menu_ID CHAR(5) PRIMARY KEY CHECK (Menu_ID LIKE '[A-Z][A-Z][0-9][0-9][0-9]'),
	Menu_Name VARCHAR(50) NOT NULL,
	Menu_Price INT NOT NULL
)

INSERT INTO Menu VALUES
('BM113','Bakmie Rebus','12000'),
('BM114','Bakmie Goreng','14000'),
('BM013','Bakmie Iblis','16000'),
('NG045','Nasi Goreng','14000'),
('KW370','Kwetiaw Kuah','17000'),
('KW641','Kwetiaw Goreng','18000')

SELECT * FROM Menu

CREATE TABLE Receipt_Details(
	Receipt_Number CHAR(10) FOREIGN KEY REFERENCES Receipt(Receipt_Number) CHECK(Receipt_Number LIKE '[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'),
	Menu_ID CHAR(5) FOREIGN KEY REFERENCES Menu(Menu_ID) CHECK (Menu_ID LIKE '[A-Z][A-Z][0-9][0-9][0-9]'),
	Quantity INT NOT NULL
	PRIMARY KEY (Receipt_Number, Menu_ID)
)

INSERT INTO Receipt_Details VALUES
('AAAAAA0001','BM113','1'),
('AAAAAB0012','BM114','1'),
('AAAABC0123','BM114','1'),
('AAAABC0123','BM013','1'),
('AAABCD1234','KW370','1'),
('AAABCD1234','KW641','1'),
('AABCDE2345','NG045','2')

SELECT * FROM Receipt_Details

