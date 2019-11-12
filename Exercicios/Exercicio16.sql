--16. LISTE OS ALUNOS QUE N�O EST�O INSCRITOS EM NENHUM CURSO
	
SELECT
	[Student].Name AS 'Student_Not_Registered'
FROM
	[Subscription]
	RIGHT JOIN [Student] ON [Subscription].StudentId = [Student].StudentId
	WHERE [Subscription].StudentId IS NULL;
-- Ver as tabelas
SELECT * FROM [Student];
SELECT * FROM [Subscription];