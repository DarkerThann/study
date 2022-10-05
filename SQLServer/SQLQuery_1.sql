USE [Curso] -- Instrução USE Garante que todos os comandos sejam executados apenas na DATABASE especificada

CREATE DATABASE [Curso] -- Cria uma DATABASE com todas as configs padrões

-- Um banco de dados armazena informações, essas informações são armazenadas em tabelas, as tabelas são uma divisão de linhas e colunas
-- Schema define como os dados são armazenados e como os dados seram lidos em diferentes tabelas

CREATE TABLE [Aluno] ( --Cria uma tabela, a sintaxe de uma tabela é definida pelo nome da coluna seguido pelo tipo
    [Id] INT,
    [Nome] NVARCHAR(80),
    [Nascimento] DATETIME,
    [Active] BIT
)
GO

ALTER TABLE [Aluno] -- Altera uma tabela. Neste Exemplo está alterando a tabela Aluno adicionando uma nova coluna Document
    ADD [Document] NVARCHAR(11)

ALTER TABLE [Aluno]
    ALTER COLUMN [Document] CHAR(11) -- Altera uma coluna. Neste exemplo o tipo de Document é alterado 

ALTER TABLE [Aluno]
    DROP COLUMN [Document] -- Exclui uma coluna. Obs: Dependendo das informações que tem no Banco e da relação dessas informações com outras informações podem ocorrer problemas ao remover uma coluna


-- Constraints
-- As restrições SQL são usadas para especificar regras para os dados de uma tabela, limitar os tipos de dados que podem entrar em uma tabela.
-- Isso garante a precisão e confiabilidade dos dados na tabela. Se houver alguma violação entre a restrição e a ação de dados, a ação será abortada.
-- As restrições pode ser em nível de coluna ou nível de tabela. As restrições de nível de coluna se aplicam a uma coluna e as restrições de nível de tabela se aplicam a toda a tabela.

-- As seguintes restrições são comumente usadas em SQL:

NOT NULL -- Garante que uma coluna não pode ter um valor NULL
UNIQUE -- Garante que todos os valores em uma coluna sejam diferentes
PRIMARY KEY -- Uma combinação de NOT NULL e UNIQUE. Identifica exclusivamente cada linha em uma tabela
FOREIGN KEY -- Impede ações que destruiriam links entre tabelas
CHECK -- Garante que os valores em uma coluna satisfaçam uma condição especifica
DEFAULT -- Define um valor padrão para uma coluna se nenhum valor for especificado
CREATE INDEX -- Usado para criar e recupear dados do banco rapidamente

DROP TABLE [Aluno]

CREATE TABLE [Aluno] (
    [Id] INT NOT NULL,
    [Nome] NVARCHAR(80) NOT NULL,
    [Email] NVARCHAR(80) NOT NULL,
    [Nascimento] DATETIME NULL,
    [Active] BIT,

    CONSTRAINT [PK_Aluno] PRIMARY KEY([Id]),
    CONSTRAINT [UQ_Aluno_Email] UNIQUE([Email])
)
GO

DROP TABLE [Curso]

CREATE TABLE [Curso] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Nome] NVARCHAR(80) NOT NULL,
    [CategoriaId] INT NOT NULL,

    CONSTRAINT [PK_Curso] PRIMARY KEY([Id]),
    CONSTRAINT [FK_Curso_Categoria] FOREIGN KEY([CategoriaId]) 
        REFERENCES [Categoria] ([Id])
)
GO

DROP TABLE [ProgressoCurso]

CREATE TABLE [ProgressoCurso] (
    [AlunoId] INT NOT NULL,
    [CursoId] INT NOT NULL,
    [Progresso] INT NOT NULL,
    [UltimaAtualizacao] DATETIME NOT NULL DEFAULT(GETDATE()),

    CONSTRAINT PK_ProgressoCurso PRIMARY KEY([AlunoId], [CursoId])
)
GO

CREATE TABLE [Categoria] (
    [Id] INT NOT NULL,
    [Nome] NVARCHAR(80) NOT NULL,

    CONSTRAINT [PK_Categoria] PRIMARY KEY ([Id])
)
GO


CREATE INDEX [IX_Aluno_Email] ON [Aluno]([Email])
DROP INDEX [IX_Aluno_Email] ON [Aluno]