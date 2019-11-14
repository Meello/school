--17. LISTE TODOS ALUNOS E EXIBA OS CAMPOS NOME DO ALUNO, NOME DO CURSO, AREA DO CONHECIMENTO, UNIDADE(CASO N�O EXISTA, INFORMAR A MENSAGEM 'N�o informado'),
-- DATA DE INICIO (DD/MM/YY), HORA DE INICIO, 'HH:MM', NOME E PERFIL DO PROFESSOR, ID DA TURMA DOS CURSOS QUE COME�AM COM A LETRA 'A'.
SELECT
	[Student].Name,
	[Course].Name,
	[InformationArea].Name,
	ISNULL([Class].Local,'N�o Informado') AS 'Local',	
	FORMAT([Class].StartDate,'dd/MM/yy') AS 'Start Date',
	FORMAT([Class].StartTime,N'hh\:mm') 'Start Time',
	[Teacher].Name,
	[Profile].Name,
	[Class].ClassId
FROM
	[Subscription]
	LEFT JOIN [Student] ON [Subscription].StudentId = [Student].StudentId
	INNER JOIN [Class] ON [Subscription].ClassId = [Class].ClassId
	INNER JOIN [Teacher] ON [Class].TeacherId = [Teacher].TeacherId
	INNER JOIN [Course] ON [Class].CourseId = [Course].CourseId
	INNER JOIN [InformationArea] ON [Course].AreaId = [InformationArea].AreaId
	INNER JOIN [TeacherProfile] ON [TeacherProfile].TeacherId = [Teacher].TeacherId
	INNER JOIN [Profile] ON [TeacherProfile].ProfileId = [Profile].ProfileId
WHERE 
	LEFT([Course].Name,1) = 'A'

