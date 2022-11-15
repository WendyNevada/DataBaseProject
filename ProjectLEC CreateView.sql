USE projectlec

--VIEW 1 // Dibuat agar pemilik restoran dapat mengetahui pendapatan harian tiap bulannya
CREATE VIEW DisplayIncome
AS
SELECT 
	DATENAME(MONTH,Receipt_Date) AS 'Month', 
	DAY(Receipt_Date) AS 'Date', 
	'Rp.' + CAST(SUM(Total_Payment) AS VARCHAR) AS Income
FROM Receipt
GROUP BY DATENAME(MONTH,Receipt_Date),DAY(Receipt_Date)

SELECT * FROM DisplayIncome

SELECT * FROM Ms_Employee

--VIEW 2// Dibuat agar pemilik restoran dapat melihat employee dengan penjualan yang tinggi (penilaian naik gaji)

CREATE VIEW DisplaySellRate
AS
SELECT
	R.ID_Karyawan,
	E.Nama_Karyawan,
	EP.Position,
	COUNT(Receipt_Number) AS SalesNumber
FROM Receipt R
JOIN Ms_Employee E ON E.ID_Karyawan = R.ID_Karyawan
JOIN Employee_Position EP ON E.Employee_PositionID = EP.Employee_PositionID
GROUP BY R.ID_Karyawan, E.Nama_Karyawan, EP.Position


SELECT * FROM DisplaySellRate
ORDER BY SalesNumber DESC


--VIEW 3 // Dibuat agar pemilik dapat mengetahui Menu yang best seller di restorannya

CREATE VIEW TopMenu
AS
SELECT 
	M.Menu_ID,
	M.Menu_Name,
	M.Menu_Price,
	SUM(RD.Quantity) AS TotalQtySold
FROM Menu M
JOIN Receipt_Details RD ON M.Menu_ID = RD.Menu_ID
GROUP BY M.Menu_ID,M.Menu_Name,M.Menu_Price


SELECT * FROM TopMenu
ORDER BY TotalQtySold DESC