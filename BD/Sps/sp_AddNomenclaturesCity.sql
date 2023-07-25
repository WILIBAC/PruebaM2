USE [tfdbcavipetrol-pa-td]
GO
/*184================================================================================================================================================================================
NOMBRE:[dbo].[sp_AddNomenclatureCity] 
FECHA:22/07/2023
AUTOR: Fredy Oswaldo Aguirre Mosquera
OBJETIVO: Crear procedimiento Almacenado que permita adicionar Nomenclaturas
MODIFICACIONES:---
NRO			FECHA				USUARIO					MODIFICACION
================================================================================================================================================================================*/
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sp_AddNomenclatureCity')
    BEGIN
        DROP  Procedure  dbo.sp_AddNomenclatureCity
    END
GO

CREATE  PROCEDURE [dbo].[sp_AddNomenclatureCity]
 (
	@p_Id  INT ,
	@p_Nomenclature VARCHAR(50),
	@p_Abbreviation VARCHAR(50)
 )
 AS
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION 
			INSERT INTO  [dbo].[Tbl_Nomenclatures]
				(	
				[Nomenclature]
				,[Abbreviation],
				[LogDate]
	
				)
				VALUES
				(	@p_Nomenclature
					,@p_Abbreviation
					,getdate()
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
  						  