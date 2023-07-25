USE [tfdbcavipetrol-pa-td]
/*9================================================================================================================================================================================
NOMBRE:[dbo].[Tbl_M2_Agent] 
FECHA0 20/07/2023
AUTOR: FREDY AGUIRRE 
OBJETIVO: Crear Tabla para registro de Resultados de Consumo de Métodos de API de Metro Cuadrado "Obtener Agentes Metodo Get".
MODIFICACIONES:---
NRO			FECHA				USUARIO					MODIFICACION

================================================================================================================================================================================*/

 IF EXISTS (SELECT * FROM sys.objects WHere object_id=OBJECT_ID(N'dbo.Tbl_M2_Agent'))
	DROP TABLE dbo.Tbl_M2_Agent 
GO
 BEGIN TRY
	CREATE TABLE [dbo].[Tbl_M2_Agent](
	[Id] [varchar] (20) NOT NULL,
	[Email] [varchar](100) NULL,
	[Name] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[DocumentNumber] [varchar](20) NULL,
	[Phone] [varchar](50) NULL,
	[Extension] [varchar](50) NULL, 
	[Mobile] [varchar](50) NULL,
	[BranchOffice] [varchar](15) NULL,
	[NameBranchOffice] [varchar](100) NULL,
	[City] [varchar](3) NULL,
	[NameCity] [varchar](50) NULL,
	[ContactWithWhatsapp] [varchar](2) NULL,
	[LogDate] [smalldatetime] DEFAULT GETDATE() NULL,
	 CONSTRAINT [PK_Tbl_M2_Agent_Id] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

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

