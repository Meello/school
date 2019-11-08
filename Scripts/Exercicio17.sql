--17. LISTE TODOS ALUNOS E EXIBA OS CAMPOS NOME DO ALUNO, NOME DO CURSO, AREA DO CONHECIMENTO, UNIDADE(CASO NÃO EXISTA, INFORMAR A MENSAGEM 'Não informado'),
-- DATA DE INICIO (DD/MM/YY), HORA DE INICIO, 'HH:MM', NOME E PERFIL DO PROFESSOR, ID DA TURMA DOS CURSOS QUE COMEÇAM COM A LETRA 'A'.
/*
	[font="Courier New"]DECLARE @date DATETIME
	DECLARE @time CHAR(5)
	SET @time = '07:45'
	SET @date = CONVERT(DATETIME,@time)
	SELECT @date
	SELECT LEFT(CONVERT(VARCHAR,@date,108),5)[/font]
*/
SELECT
	[Student].Name,
	[Course].Name,
	[InformationArea].Name,
	CASE
		WHEN [Class].Local IS NULL THEN 'Não Informado'
		ELSE [Class].Local
	END AS 'Local',	
	(SELECT CONVERT(char(10),[Class].StartDate,1)) AS 'Start Date',
	(SELECT LEFT(CONVERT(time,[Class].StartTime,108),5)) 'Start Time',
	[Teacher].Name,
	[Profile].Name,
	IIF( LEFT([Course].Name,1) = 'A',[Class].ClassId,NULL)
FROM
	[Subscription]
	LEFT JOIN [Student] ON [Subscription].StudentId = [Student].StudentId
	INNER JOIN [Class] ON [Subscription].ClassId = [Class].ClassId
	INNER JOIN [Teacher] ON [Class].TeacherId = [Teacher].TeacherId
	INNER JOIN [Course] ON [Class].CourseId = [Course].CourseId
	INNER JOIN [InformationArea] ON [Course].AreaId = [InformationArea].AreaId
	INNER JOIN [TeacherProfile] ON [TeacherProfile].TeacherId = [Teacher].TeacherId
	INNER JOIN [Profile] ON [TeacherProfile].ProfileId = [Profile].ProfileId
	

