USE [tfdbcavipetrol-pa-td]
/*9================================================================================================================================================================================
NOMBRE:[dbo].[Tbl_M2_ResponseUrl] 
FECHA0 20/07/2023
AUTOR: FREDY AGUIRRE 
OBJETIVO: Crear Tabla para registro de Resultados de respuesta de Consumo de Métodos de API de Metro Cuadrado.
MODIFICACIONES:---
NRO			FECHA				USUARIO					MODIFICACION

================================================================================================================================================================================*/

 IF EXISTS (SELECT * FROM sys.objects WHere object_id=OBJECT_ID(N'[dbo].[Tbl_M2_ResponseUrl]'))
	DROP TABLE dbo.Tbl_M2_ResponseUrl
GO
 BEGIN TRY
	CREATE TABLE [dbo].[Tbl_M2_ResponseUrl](
		[Id] [varchar](100) NOT NULL,
		[Code] [int] NULL,
		[CreationDate] [datetime] NULL,
		[UpdatedDate] [datetime] NULL,
		[ResourceId] [varchar](100) NOT NULL,
		[MessageList] [varchar](1000) NULL,
		[LogDate] [datetime] default GETDATE() NULL,
		CONSTRAINT [PK_tblM2_Response_Id] PRIMARY KEY CLUSTERED 
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
