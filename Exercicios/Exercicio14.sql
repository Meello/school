--14. EXIBA O MENOR, A M�DIA, O MAIOR E A SOMA DOS SAL�RIOS DOS PROFESSORES
SELECT 
	MIN([Teacher].Salary) AS 'Smallest Salary',
	AVG([Teacher].Salary) AS 'Average',
	MAX([Teacher].Salary) AS 'Biggest Salary'
FROM
	[Teacher]