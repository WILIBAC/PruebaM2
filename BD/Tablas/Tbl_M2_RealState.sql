USE [tfdbcavipetrol-pa-td]
/*9================================================================================================================================================================================
NOMBRE:[dbo].[Tbl_M2_RealState] 
FECHA0 22/07/2023
AUTOR: FREDY AGUIRRE 
OBJETIVO: Crear Tabla para registro de Inmueble para consumir de Métodos POST de API de Metro Cuadrado "Crear Inmueble". 
MODIFICACIONES:---
NRO			FECHA				USUARIO					MODIFICACION

================================================================================================================================================================================*/

 IF EXISTS (SELECT * FROM sys.objects WHere object_id=OBJECT_ID(N'dbo.Tbl_M2_RealState'))
	DROP TABLE dbo.Tbl_M2_RealState 
GO
 BEGIN TRY
	CREATE TABLE [dbo].[Tbl_M2_RealState](
	[Id] [int] PRIMARY KEY IDENTITY NOT NULL
	,[IdAsociado] VARCHAR(50) NOT NULL
	,[ResourceId] VARCHAR(250) NOT NULL
	,[RealEstateType] INT NOT NULL
    ,[RealEstateOffer] INT NOT NULL
    ,[Price] DECIMAL(20,2) NOT NULL 
	,[City] VARCHAR(100) NOT NULL
    ,[Administration] VARCHAR (30) NULL 
	,[Images] VARCHAR(MAX) NOT NULL 
    ,[Comments] VARCHAR(Max) NULL
    ,[Stratum] INT NULL
	,[Address] VARCHAR(1000) NULL
    ,[Neighborhood] VARCHAR(500) NOT NULL 
	,[AgentId] INT NULL
    ,[Latitude] VARCHAR(50) NULL
	,[Longitude] VARCHAR(50) NULL
	,[Video] VARCHAR(Max) NULL
	,[ResponseUrl] VARCHAR(Max) NOT NULL
	,[Amenities] VARCHAR(MAX) NOT NULL
	,[logDate] DATETIME DEFAULT GETDATE() NULL
	)

    END TRY
    BEGIN CATCH
DECLARE  @ErrorMessage VARCHAR(4000),
         @ErrorSeverity INT,
         @ErrorState INT;

SELECT @ErrorMessage =ERROR_MESSAGE(),
       @ErrorSeverity=ERROR_SEVERITY(),
       @ErrorState=ERROR_STATE();
      RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
   END CATCH
