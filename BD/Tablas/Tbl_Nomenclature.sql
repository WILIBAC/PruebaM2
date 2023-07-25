
if OBJECT_ID('[dbo].Tbl_Nomenclatures') IS NOT NULL
    BEGIN 
    DROP TABLE [dbo].Tbl_Nomenclatures
if OBJECT_ID('[dbo].Tbl_Nomenclatures') IS NOT NULL
    PRINT '<<<< FAILED DROPPING TABLE [dbo].Tbl_Nomenclatures >>>>'
ELSE 
    PRINT '<<<< DROPPED TABLE [dbo].Tbl_Nomenclatures >>>>'
END 
GO
	BEGIN
        CREATE TABLE  [dbo].Tbl_Nomenclatures (
                    IdNomenclature [INT] IDENTITY NOT NULL,
                    Nomenclature [varchar](50) NOT NULL,
					Abbreviation [varchar](50) NOT NULL,
					LogDate DATE NOT NULL
                    )
    END
    
go