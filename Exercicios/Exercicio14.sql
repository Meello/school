--14. EXIBA O MENOR, A MÉDIA, O MAIOR E A SOMA DOS SALÁRIOS DOS PROFESSORES
/*
	SELECT TOP (expression) [PERCENT] [WITH TIES]
		colmuns
	FROM 
	    table_name
	ORDER BY 
	    column_name;  
*/
SELECT TOP(1) WITH TIES
	Name,
	Salary AS 'Smallest_Salary'
FROM
	[Teacher]
ORDER BY 
	Salary ASC;

SELECT 
	AVG(Salary) AS 'Average_Salary'
FROM [Teacher];

SELECT TOP(1) WITH TIES
	Name,
	Salary AS 'Biggest_Salary'
FROM
	[Teacher]
ORDER BY 
	Salary DESC;

SELECT 
	SUM(Salary) AS 'Sum_Salary'
FROM [Teacher];