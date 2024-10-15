-- creacio base de datos educacion_superior
CREATE DATABASE edu_superior

-- usar la database
USE edu_superior
------------------------------------------------------------------------------
---------|               LIMPIEZA DE DATOS                |-------------------
------------------------------------------------------------------------------
-- Renombrar columnas a minúsculas en la tabla 'principal'

EXEC sp_rename 'principal.[CÓDIGO DE LA INSTITUCIÓN]', 'codigo_institucion', 'COLUMN'; -- * codigo_institucion
EXEC sp_rename 'principal.[IES_PADRE]', 'ies_padre', 'COLUMN'; -- * ies_padre
EXEC sp_rename 'principal.[INSTITUCIÓN DE EDUCACIÓN SUPERIOR (IES)]', 'nombre_institucion', 'COLUMN'; -- * institucion_educacion_superior
EXEC sp_rename 'principal.[PRINCIPAL O SECCIONAL]', 'principal_seccional', 'COLUMN'; -- * principal_seccional
EXEC sp_rename 'principal.[ID SECTOR IES]', 'id_sector_ies', 'COLUMN'; -- * id_sector_ies
EXEC sp_rename 'principal.[SECTOR IES]', 'sector_ies', 'COLUMN'; -- * sector_ies
EXEC sp_rename 'principal.[IES ACREDITADA]', 'ies_acreditada', 'COLUMN'; -- * ies_acreditada
EXEC sp_rename 'principal.[ID CARACTER]', 'id_caracter', 'COLUMN'; -- * id_caracter
EXEC sp_rename 'principal.[CARACTER IES]', 'caracter_ies', 'COLUMN'; -- * caracter_ies
EXEC sp_rename 'principal.[CÓDIGO DEL DEPARTAMENTO (IES)]', 'codigo_departamento', 'COLUMN'; -- * codigo_departamento_ies
EXEC sp_rename 'principal.[DEPARTAMENTO DE DOMICILIO DE LA IES]', 'nombre_departamento', 'COLUMN'; -- * departamento_domicilio_ies
EXEC sp_rename 'principal.[CÓDIGO DEL MUNICIPIO (IES)]', 'codigo_municipio', 'COLUMN'; -- * codigo_municipio_ies
EXEC sp_rename 'principal.[MUNICIPIO DE DOMICILIO DE LA IES]', 'nombre_municipio', 'COLUMN'; -- * municipio_domicilio_ies
EXEC sp_rename 'principal.[CÓDIGO SNIES DEL PROGRAMA]', 'codigo_snies_programa', 'COLUMN'; -- * codigo_snies_programa
EXEC sp_rename 'principal.[PROGRAMA ACADÉMICO]', 'programa_academico', 'COLUMN'; -- * programa_academico
EXEC sp_rename 'principal.[PROGRAMA ACREDITADO]', 'programa_acreditado', 'COLUMN'; -- * programa_acreditado
EXEC sp_rename 'principal.[ID NIVEL ACADÉMICO]', 'id_nivel_academico', 'COLUMN'; -- * id_nivel_academico
EXEC sp_rename 'principal.[NIVEL ACADÉMICO]', 'nivel_academico', 'COLUMN'; -- * nivel_academico
EXEC sp_rename 'principal.[ID NIVEL DE FORMACIÓN]', 'id_nivel_formacion', 'COLUMN'; -- * id_nivel_formacion
EXEC sp_rename 'principal.[NIVEL DE FORMACIÓN]', 'nivel_formacion', 'COLUMN'; -- * nivel_formacion
EXEC sp_rename 'principal.[ID METODOLOGÍA]', 'id_metodologia', 'COLUMN'; -- * id_metodologia
EXEC sp_rename 'principal.[METODOLOGÍA]', 'metodologia', 'COLUMN'; -- * metodologia
EXEC sp_rename 'principal.[ID ÁREA DE CONOCIMIENTO]', 'id_area_conocimiento', 'COLUMN'; -- * id_area_conocimiento
EXEC sp_rename 'principal.[ÁREA DE CONOCIMIENTO]', 'area_conocimiento', 'COLUMN'; -- * area_conocimiento
EXEC sp_rename 'principal.[ID NÚCLEO]', 'id_nucleo_basico_conocimiento', 'COLUMN'; -- * id_nucleo
EXEC sp_rename 'principal.[NÚCLEO BÁSICO DEL CONOCIMIENTO (NBC)]', 'nucleo_basico_conocimiento', 'COLUMN'; -- * nucleo_basico_conocimiento 
EXEC sp_rename 'principal.[ID CINE CAMPO AMPLIO]', 'id_cine_campo_amplio', 'COLUMN'; -- * id_cine_campo_amplio
EXEC sp_rename 'principal.[DESC CINE CAMPO AMPLIO]', 'desc_cine_campo_amplio', 'COLUMN'; -- * desc_cine_campo_amplio
EXEC sp_rename 'principal.[ID CINE CAMPO ESPECIFICO]', 'id_cine_campo_especifico', 'COLUMN'; -- * id_cine_campo_especifico
EXEC sp_rename 'principal.[DESC CINE CAMPO ESPECIFICO]', 'desc_cine_campo_especifico', 'COLUMN'; -- * desc_cine_campo_especifico
EXEC sp_rename 'principal.[ID CINE CODIGO DETALLADO]', 'id_cine_codigo_detallado', 'COLUMN'; -- * id_cine_codigo_detallado
EXEC sp_rename 'principal.[DESC CINE CODIGO DETALLADO]', 'desc_cine_codigo_detallado', 'COLUMN'; -- * desc_cine_codigo_detallado

EXEC sp_rename 'principal.[CÓDIGO DEL DEPARTAMENTO (PROGRAMA)]', 'codigo_departamento_programa', 'COLUMN'; -- * codigo_departamento_programa
EXEC sp_rename 'principal.[DEPARTAMENTO DE OFERTA DEL PROGRAMA]', 'departamento_oferta_programa', 'COLUMN'; -- * departamento_oferta_programa
EXEC sp_rename 'principal.[CÓDIGO DEL MUNICIPIO (PROGRAMA)]', 'codigo_municipio_programa', 'COLUMN'; -- * codigo_municipio_programa
EXEC sp_rename 'principal.[MUNICIPIO DE OFERTA DEL PROGRAMA]', 'municipio_oferta_programa', 'COLUMN'; -- * municipio_oferta_programa

EXEC sp_rename 'principal.[ID SEXO]', 'id_sexo', 'COLUMN'; -- * id_sexo
EXEC sp_rename 'principal.[SEXO]', 'sexo', 'COLUMN'; -- * sexo
EXEC sp_rename 'principal.[AÑO]', 'año', 'COLUMN'; -- * año
EXEC sp_rename 'principal.[SEMESTRE]', 'semestre', 'COLUMN'; -- * semestre
EXEC sp_rename 'principal.[PRIMER CURSO]', 'primer_curso', 'COLUMN'; -- * primer_curso

SELECT * FROM principal


SELECT * FROM sys.types;  
GO

SELECT * 
FROM principal
WHERE codigo_institucion IS NOT NULL

----------------------------------------------------------------------------------------------------------------------------------------------------- 

------------------------------------------------------------------------------
---------|               CREACION DE TABLAS               |-------------------
------------------------------------------------------------------------------

-- crear y insertar datos a la Tabla: Departamento
--------------------------------------------------------
CREATE TABLE Departamento (
    codigo_departamento INT NOT NULL, -- codigo_departamento INT PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL
);

INSERT INTO Departamento (codigo_departamento, nombre_departamento)
SELECT DISTINCT codigo_departamento, nombre_departamento
FROM principal;

---------------------------------------------------------------------------------------------

-- crear Tabla: Municipio
---------------------------------------------------------------------------------------------
CREATE TABLE Municipio (
    codigo_municipio INT NOT NULL, -- codigo_municipio INT PRIMARY KEY,
    nombre_municipio VARCHAR(100) NOT NULL,
    codigo_departamento INT NOT NULL,  -- FK hacia la tabla Departamento    
);

INSERT INTO Municipio (
	codigo_municipio, 
	nombre_municipio, 
	codigo_departamento)
SELECT DISTINCT codigo_municipio, nombre_municipio, codigo_departamento
FROM principal;

---------------------------------------------------------------------------------------------

-- crear Tabla: Institucion
---------------------------------------------------------------------------------------------
CREATE TABLE Institucion (
    codigo_institucion INT NOT NULL,-- codigo_institucion INT PRIMARY KEY,
    ies_padre VARCHAR(100) NOT NULL,
    nombre_institucion VARCHAR(200) NOT NULL,
    principal_seccional VARCHAR(50)NOT NULL,
    id_sector_ies INT NOT NULL,
    sector_ies VARCHAR(100) NOT NULL,
    ies_acreditada VARCHAR(200) NOT NULL,
    id_caracter INT NOT NULL,
    caracter_ies VARCHAR(100) NOT NULL,
    codigo_departamento INT NOT NULL,  -- FK hacia la tabla Departamento
    codigo_municipio INT NOT NULL,     -- FK hacia la tabla Municipio
    
);

-- insertando datos
INSERT INTO Institucion (
	codigo_institucion, 
	ies_padre, 
	nombre_institucion, 
	principal_seccional, 
	id_sector_ies, 
	sector_ies, 
	ies_acreditada, 
	id_caracter, 
	caracter_ies,
	codigo_departamento,
	codigo_Municipio)
SELECT DISTINCT 
	codigo_institucion, 
	ies_padre, 
	nombre_institucion, 
	principal_seccional, 
	id_sector_ies, 
	sector_ies, 
	ies_acreditada, 
	id_caracter, 
	caracter_ies,
	codigo_departamento,
	codigo_Municipio

FROM principal;

---------------------------------------------------------------------------------------------

-- crear Tabla: NivelAcademico
---------------------------------------------------------------------------------------------

CREATE TABLE NivelAcademico (
    id_nivel_academico INT NOT NULL, -- id_nivel_academico INT PRIMARY KEY,
    nivel_academico VARCHAR(100) NOT NULL
);

INSERT INTO NivelAcademico (
	id_nivel_academico,
	nivel_academico)
SELECT DISTINCT
	id_nivel_academico,
	nivel_academico
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: NivelFormacion
---------------------------------------------------------------------------------------------
CREATE TABLE NivelFormacion (
    id_nivel_formacion INT NOT NULL, -- id_nivel_formacion INT PRIMARY KEY,
    nivel_formacion VARCHAR(100) NOT NULL
);

INSERT INTO NivelFormacion (
	id_nivel_formacion,
	nivel_formacion)
SELECT DISTINCT
	id_nivel_formacion,
	nivel_formacion
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: Metodologia
---------------------------------------------------------------------------------------------
CREATE TABLE Metodologia (
    id_metodologia INT NOT NULL, -- id_metodologia INT PRIMARY KEY,
    metodologia VARCHAR(100) NOT NULL
);

INSERT INTO Metodologia (
	id_metodologia,
	metodologia)
SELECT DISTINCT
	id_metodologia,
	metodologia
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: AreaConocimiento
---------------------------------------------------------------------------------------------
CREATE TABLE AreaConocimiento (
    id_area_conocimiento INT NOT NULL, -- id_area_conocimiento INT PRIMARY KEY,
    area_conocimiento VARCHAR(100) NOT NULL
);

INSERT INTO AreaConocimiento (
	id_area_conocimiento,
	area_conocimiento)
SELECT DISTINCT
	id_area_conocimiento,
	area_conocimiento
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: NucleoBasicoConocimiento
---------------------------------------------------------------------------------------------
CREATE TABLE NucleoBasicoConocimiento (
    id_nucleo_basico_conocimiento INT NOT NULL, -- id_nucleo_basico_conocimiento INT PRIMARY KEY,
    nucleo_basico_conocimiento VARCHAR(200) NOT NULL
);

INSERT INTO NucleoBasicoConocimiento (
	id_nucleo_basico_conocimiento,
	nucleo_basico_conocimiento)
SELECT DISTINCT
	id_nucleo_basico_conocimiento,
	nucleo_basico_conocimiento
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: CINE Campo Amplio
-------------------------------------------------------- AQUI QUEDAMOS

CREATE TABLE CineCampoAmplio (
    id_cine_campo_amplio INT NOT NULL , -- id_cine_campo_amplio INT PRIMARY KEY,
    desc_cine_campo_amplio VARCHAR(200) NOT NULL
);

INSERT INTO CineCampoAmplio (
	id_cine_campo_amplio,
	desc_cine_campo_amplio)
SELECT DISTINCT
	id_cine_campo_amplio,
	desc_cine_campo_amplio
FROM principal
---------------------------------------------------------------------------------------------

-- crear Tabla: CINE Campo Específico
---------------------------------------------------------------------------------------------

CREATE TABLE CineCampoEspecifico (
    id_cine_campo_especifico INT NOT NULL, -- id_cine_campo_especifico INT PRIMARY KEY,
    desc_cine_campo_especifico VARCHAR(200) NOT NULL,
    id_cine_campo_amplio INT NOT NULL  -- FK hacia CineCampoAmplio    
);

INSERT INTO CineCampoEspecifico (
	id_cine_campo_especifico,
	desc_cine_campo_especifico,
	id_cine_campo_amplio)
SELECT DISTINCT
	id_cine_campo_especifico,
	desc_cine_campo_especifico,
	id_cine_campo_amplio
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: CINE Código Detallado
---------------------------------------------------------------------------------------------

CREATE TABLE CineCodigoDetallado (
    id_cine_codigo_detallado INT NOT NULL, -- id_cine_codigo_detallado INT PRIMARY KEY,
    desc_cine_codigo_detallado VARCHAR(200) NOT NULL,
    id_cine_campo_especifico INT NOT NULL -- FK hacia CineCampoEspecifico
);

INSERT INTO CineCodigoDetallado (
	id_cine_codigo_detallado,
	desc_cine_codigo_detallado,
	id_cine_campo_especifico)
SELECT DISTINCT
	id_cine_codigo_detallado,
	desc_cine_codigo_detallado,
	id_cine_campo_especifico
FROM principal

---------------------------------------------------------------------------------------------

-- crear Tabla: ProgramaAcademico
---------------------------------------------------------------------------------------------

CREATE TABLE ProgramaAcademico (
    codigo_snies_programa INT NOT NULL, -- codigo_snies_programa INT PRIMARY KEY,
    programa_academico VARCHAR(200) NOT NULL,
    programa_acreditado VARCHAR(200) NOT NULL,
    codigo_departamento_programa INT,   
    codigo_municipio_programa INT,      
    id_nivel_academico INT,             -- FK hacia NivelAcademico
    id_nivel_formacion INT,             -- FK hacia NivelFormacion
    id_metodologia INT,                 -- FK hacia Metodologia
    id_area_conocimiento INT,           -- FK hacia AreaConocimiento
    id_nucleo_basico_conocimiento INT,  -- FK hacia NucleoBasicoConocimiento
    id_cine_campo_amplio INT,           -- FK hacia CineCampoAmplio
    id_cine_campo_especifico INT,       -- FK hacia CineCampoEspecifico
    id_cine_codigo_detallado INT,       -- FK hacia CineCodigoDetallado    
);

EXEC sp_rename 'ProgramaAcademico.codigo_departamento', 'codigo_departamento_programa', 'COLUMN';
EXEC sp_rename 'ProgramaAcademico.codigo_municipio', 'codigo_municipio_programa', 'COLUMN';

-- Identificar los Nombres de las Restricciones de FK
SELECT 
    OBJECT_NAME(constraint_object_id) AS ConstraintName,
    OBJECT_NAME(parent_object_id) AS TableName,
    COL_NAME(parent_object_id, parent_column_id) AS ColumnName
FROM sys.foreign_key_columns
WHERE OBJECT_NAME(parent_object_id) = 'ProgramaAcademico';

-- Eliminar llves FK
ALTER TABLE ProgramaAcademico
DROP CONSTRAINT FK_ProgramaAcademico_Departamento

ALTER TABLE ProgramaAcademico
DROP CONSTRAINT FK_ProgramaAcademico_Municipio

SELECT * FROM ProgramaAcademico

-------------------------------------

INSERT INTO ProgramaAcademico (
    codigo_snies_programa,
    programa_academico,
    programa_acreditado,
    codigo_departamento_programa,
    codigo_municipio_programa,
    id_nivel_academico,
    id_nivel_formacion,
    id_metodologia,
    id_area_conocimiento,
    id_nucleo_basico_conocimiento,
    id_cine_campo_amplio,
    id_cine_campo_especifico,
    id_cine_codigo_detallado
)
SELECT DISTINCT
    codigo_snies_programa,
    programa_academico,
    programa_acreditado,
    codigo_departamento_programa,
    codigo_municipio_programa,
    id_nivel_academico,
    id_nivel_formacion,
    id_metodologia,
    id_area_conocimiento,
    id_nucleo_basico_conocimiento,
    id_cine_campo_amplio,
    id_cine_campo_especifico,
    id_cine_codigo_detallado
FROM principal;

---------------------------------------------------------------------------------------------

-- crear Tabla: Estudiante
---------------------------------------------------------------------------------------------

CREATE TABLE Estudiante (
    id_sexo INT NOT NULL, -- id_sexo PRIMARY KEY
    sexo VARCHAR(20) NOT NULL,    
    ano INT NOT NULL,
    semestre INT NOT NULL,
    primer_curso VARCHAR(200) NOT NULL,
	codigo_institucion INT NOT NULL,  -- FK hacia Institucion
    codigo_snies_programa INT NOT NULL, -- FK hacia ProgramaAcademico
);

EXEC sp_rename 'principal.año','ano','COLUMN';

-- Identificar los Nombres de las Restricciones de FK
SELECT 
    OBJECT_NAME(constraint_object_id) AS ConstraintName,
    OBJECT_NAME(parent_object_id) AS TableName,
    COL_NAME(parent_object_id, parent_column_id) AS ColumnName
FROM sys.foreign_key_columns
WHERE OBJECT_NAME(parent_object_id) = 'Estudiante';

-- Eliminar llves FK
ALTER TABLE Estudiante
DROP CONSTRAINT FK_Estudiante_Institucion

ALTER TABLE Estudiante
DROP CONSTRAINT FK_Estudiante_ProgramaAcademico

-- eliminar llaves PK
SELECT 
    name AS ConstraintName,
    OBJECT_NAME(parent_object_id) AS TableName
FROM sys.key_constraints
WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = 'Estudiante';

ALTER TABLE Estudiante
DROP CONSTRAINT PK_Estudiante;

-- eliminar columna id_estudiante
ALTER TABLE Estudiante
DROP COLUMN id_estudiante

SELECT * FROM Estudiante

INSERT INTO Estudiante (
	id_sexo, 
	sexo,
	ano, 
	semestre, 
	primer_curso, 
	codigo_institucion, 
	codigo_snies_programa)
SELECT
    id_sexo,
    sexo,
    ano,
    semestre,
    primer_curso,
	codigo_institucion, 
	codigo_snies_programa
FROM principal;

------------------------------------------------------------------------------
---------|               ASIGNANDO PRIMARY KEY            |-------------------
------------------------------------------------------------------------------

-- PK Departamento
ALTER TABLE Departamento
ADD CONSTRAINT PK_Departamento PRIMARY KEY (codigo_departamento)

-- PK Municipio
ALTER TABLE Municipio
ADD CONSTRAINT PK_Municipio PRIMARY KEY (codigo_municipio)

-- PK Institucion
ALTER TABLE Institucion
ADD CONSTRAINT PK_Institucion PRIMARY KEY (codigo_institucion)

-- PK NivelAcademico
ALTER TABLE NivelAcademico
ADD CONSTRAINT PK_NivelAcademico PRIMARY KEY (id_nivel_academico)

-- PK NivelFormacion
ALTER TABLE NivelFormacion
ADD CONSTRAINT PK_NivelFormacion PRIMARY KEY (id_nivel_formacion)

-- PK Metodologia
ALTER TABLE Metodologia
ADD CONSTRAINT PK_Metodologia PRIMARY KEY (id_metodologia)

-- PK AreaConocimiento
ALTER TABLE AreaConocimiento
ADD CONSTRAINT PK_AreaConocimiento PRIMARY KEY (id_area_conocimiento)

-- PK NucleoBasicoConocimiento
ALTER TABLE NucleoBasicoConocimiento
ADD CONSTRAINT PK_NucleoBasicoConocimiento PRIMARY KEY (id_nucleo_basico_conocimiento)

-- PK CineCampoAmplio
ALTER TABLE CineCampoAmplio
ADD CONSTRAINT PK_CineCampoAmplio PRIMARY KEY (id_cine_campo_amplio)

-- PK CineCampoEspecifico
ALTER TABLE CineCampoEspecifico
ADD CONSTRAINT PK_CineCampoEspecifico PRIMARY KEY (id_cine_campo_especifico)

----------------------------------------------------------------------------------
-- eliminar duplicados de la tabla CineCodigoDetallado
SELECT id_cine_codigo_detallado, COUNT(*)
FROM CineCodigoDetallado
GROUP BY id_cine_codigo_detallado
HAVING COUNT(*) > 1;

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY id_cine_codigo_detallado ORDER BY (SELECT NULL)) AS rn
    FROM CineCodigoDetallado
)
DELETE FROM CTE WHERE rn > 1;

-- PK CineCodigoDetallado
ALTER TABLE CineCodigoDetallado
ADD CONSTRAINT PK_CineCodigoDetallado PRIMARY KEY (id_cine_codigo_detallado)

-----------------------------------------------------------------------------------
-- eliminar duplicados de la tabla ProgramaAcademico
SELECT codigo_snies_programa, COUNT(*)
FROM ProgramaAcademico
GROUP BY codigo_snies_programa
HAVING COUNT(*) > 1;

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY codigo_snies_programa ORDER BY (SELECT NULL)) AS rn
    FROM ProgramaAcademico
)
DELETE FROM CTE WHERE rn > 1;

-- PK ProgramaAcademico
ALTER TABLE ProgramaAcademico
ADD CONSTRAINT PK_ProgramaAcademico PRIMARY KEY (codigo_snies_programa)

--------------------------------------------------------------------------------
-- elimanar duplicados de la tabla Estudiante

SELECT id_sexo, COUNT(*)
FROM Estudiante
GROUP BY id_sexo
HAVING COUNT(*) > 1;

WITH CTE AS(
	SELECT *,
		ROW_NUMBER() OVER (PARTITION BY id_sexo ORDER BY (SELECT NULL)) AS rn
	FROM Estudiante
)
DELETE FROM CTE WHERE rn > 1;

-- PK Estudiante
ALTER TABLE Estudiante
ADD CONSTRAINT PK_Estudiante PRIMARY KEY (id_sexo)


------------------------------------------------------------------------------
---------|               ASIGNANDO FOREIGN KEY            |-------------------
------------------------------------------------------------------------------

-- asignando fk de departamento

ALTER TABLE Municipio
ADD CONSTRAINT FK_Municipio_Departamento
FOREIGN KEY (codigo_departamento) REFERENCES Departamento(codigo_departamento);

-- asignando fk

ALTER TABLE Institucion
ADD CONSTRAINT FK_Institucion_Departamento
FOREIGN KEY (codigo_departamento) REFERENCES Departamento(codigo_departamento);

ALTER TABLE Institucion
ADD CONSTRAINT FK_Institucion_Municipio
FOREIGN KEY (codigo_municipio) REFERENCES Municipio(codigo_municipio);

-- asignando fk

ALTER TABLE CineCampoEspecifico
ADD CONSTRAINT FK_CineCampoEspecifico_CineCampoAmplio
FOREIGN KEY (id_cine_campo_amplio) REFERENCES CineCampoAmplio(id_cine_campo_amplio);

-- ASIGNAR FK
ALTER TABLE CineCodigoDetallado
ADD CONSTRAINT FK_CineCodigoDetallado_CineCampoEspecifico
FOREIGN KEY (id_cine_campo_especifico) REFERENCES CineCampoEspecifico(id_cine_campo_especifico);

-- asignar fk
ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_NivelAcademico
FOREIGN KEY (id_nivel_academico) REFERENCES NivelAcademico(id_nivel_academico);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_NivelFormacion
FOREIGN KEY (id_nivel_formacion) REFERENCES NivelFormacion(id_nivel_formacion);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_Metodologia
FOREIGN KEY (id_metodologia) REFERENCES Metodologia(id_metodologia);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_AreaConocimiento
FOREIGN KEY (id_area_conocimiento) REFERENCES AreaConocimiento(id_area_conocimiento);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_NucleoBasicoConocimiento
FOREIGN KEY (id_nucleo_basico_conocimiento) REFERENCES NucleoBasicoConocimiento(id_nucleo_basico_conocimiento);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_CineCampoAmplio
FOREIGN KEY (id_cine_campo_amplio) REFERENCES CineCampoAmplio(id_cine_campo_amplio);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_CineCampoEspecifico
FOREIGN KEY (id_cine_campo_especifico) REFERENCES CineCampoEspecifico(id_cine_campo_especifico);

ALTER TABLE ProgramaAcademico
ADD CONSTRAINT FK_ProgramaAcademico_CineCodigoDetallado
FOREIGN KEY (id_cine_codigo_detallado) REFERENCES CineCodigoDetallado(id_cine_codigo_detallado);

-- ASIGNAR FK
ALTER TABLE Estudiante
ADD CONSTRAINT FK_Estudiante_ProgramaAcademico
FOREIGN KEY (codigo_snies_programa) REFERENCES ProgramaAcademico(codigo_snies_programa);

ALTER TABLE Estudiante
ADD  CONSTRAINT FK_Estudiante_Institucion
FOREIGN KEY (codigo_institucion) REFERENCES Institucion(codigo_institucion)


------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
---------|               CONSULTAS                        |-------------------
------------------------------------------------------------------------------
USE edu_superior

SELECT codigo_departamento_programa FROM principal
SELECT codigo_departamento FROM Departamento


-- CONSULTA INNER JOINS
-- INNER JOIN: Devuelve todas las filas cuando hay al menos una coincidencia en ambas tablas.

SELECT
	ProgramaAcademico.codigo_snies_programa,
	ProgramaAcademico.programa_academico,
	Estudiante.id_sexo,
	Estudiante.ano	
FROM
	ProgramaAcademico
INNER JOIN
	Estudiante ON ProgramaAcademico.codigo_snies_programa = Estudiante.codigo_snies_programa;

SELECT 
	Departamento.codigo_departamento,
	Departamento.nombre_departamento,
	Municipio.codigo_municipio,
	Municipio.nombre_municipio
FROM Departamento
INNER JOIN
	Municipio ON Departamento.codigo_departamento = Municipio.codigo_departamento

-- CONSULTA LEFT JOIN
-- LEFT JOIN: Devuelve todas las filas de la tabla de la izquierda, y las filas coincidentes de la tabla de la derecha.

SELECT 
	Departamento.codigo_departamento,
	Departamento.nombre_departamento,
	Municipio.codigo_municipio,
	Municipio.nombre_municipio
FROM Departamento
LEFT JOIN
	Municipio ON Departamento.codigo_departamento = Municipio.codigo_departamento



