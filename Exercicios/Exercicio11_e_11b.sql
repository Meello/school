--11. LISTE O SALARIO E O NOME E O SALÁRIO DO PROFESSOR QUE GANHA MAIS
/*
	CREATE VIEW view_name AS
	SELECT column1, column2, ...
	FROM table_name
	WHERE condition;

	SELECT MIN(Price) AS SmallestPrice
	FROM Products;
	SELECT MAX(Price) AS BiggestPrice
	FROM Products;
*/
SELECT
	[Teacher].Name, [Teacher].Salary
FROM 
	[Teacher]
	ORDER BY [Teacher].Salary DESC;

SELECT
	MAX([Teacher].Salary) AS Teacher_Biggest_Salary
FROM [Teacher];

/*
	Como eu pego a linha inteira?
*/

--11b. LISTE O SALARIO E O NOME E O SALÁRIO DO PROFESSORES QUE GANHAM MENOS
SELECT
	[Teacher].Name, [Teacher].Salary
FROM 
	[Teacher]
	ORDER BY [Teacher].Salary ASC;

SELECT
	MIN([Teacher].Salary) AS Teacher_Smallest_Salary
FROM [Teacher];
