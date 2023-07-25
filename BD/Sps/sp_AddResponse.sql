USE [tfdbcavipetrol-pa-td]
GO
/*184================================================================================================================================================================================
NOMBRE:[dbo].[sp_AddM2ResponseUrl] 
FECHA:22/07/2023
AUTOR: Fredy Oswaldo Aguirre Mosquera
OBJETIVO: Crear procedimiento Almacenado que permita adicionar Respuesta de una operacion de M2 
MODIFICACIONES:---
NRO			FECHA				USUARIO					MODIFICACION
================================================================================================================================================================================*/
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sp_AddM2ResponseUrl')
    BEGIN
        DROP  Procedure  dbo.sp_AddM2ResponseUrl
    END
GO

CREATE  PROCEDURE [dbo].[sp_AddM2ResponseUrl]
 (
	@p_Id  VARCHAR(100)
	,@p_Code INT
	,@p_CreationDate DATETIME
	,@p_UpdateDate DATETIME
	,@p_ResourcerId VARCHAR(100)
	,@p_MessageList VARCHAR(1000)
 )
 AS
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION 
			INSERT INTO  [dbo].[Tbl_M2_ResponseUrl]
				(	
				[Id]
				,[Code]
				,[CreationDate]
				,[UpdatedDate]
				,[ResourceId]
				,[MessageList]
				)
				VALUES
				(	
					@p_Id  
					,@p_Code
					,@p_CreationDate 
					,@p_UpdateDate 
					,@p_ResourcerId
					,@p_MessageList 
				)
		COMMIT TRANSACTION
		select  'OK' status
	END TRY
	BEGIN CATCH
		DECLARE  @ErrorMessage VARCHAR(4000),
				 @ErrorSeverity INT,
				 @ErrorState INT;

		SELECT @ErrorMessage =ERROR_MESSAGE(),
			   @ErrorSeverity=ERROR_SEVERITY(),
			   @ErrorState=ERROR_STATE();
			   ROLLBACK TRANSACTION
			  RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
	END CATCH

END 
  						  