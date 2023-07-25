USE [tfdbcavipetrol-pa-td]
GO
/*184================================================================================================================================================================================
NOMBRE:[dbo].[sp_M2_RealState] 
FECHA:22/07/2023
AUTOR: Fredy Oswaldo Aguirre Mosquera
OBJETIVO: Crear procedimiento Almacenado que permita Gestionar Informacion de un Inmueble de Metro Cuadrado.
MODIFICACIONES:---
NRO			FECHA				USUARIO					MODIFICACION
================================================================================================================================================================================*/
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sp_M2_RealState')
    BEGIN
        DROP  Procedure  dbo.sp_M2_RealState
    END
GO

CREATE  PROCEDURE [dbo].[sp_M2_RealState]
 (
	 @p_IdAsociado VARCHAR(20)
	,@p_ResourceId VARCHAR(250)
	,@p_RealEstateType INT
    ,@p_RealEstateOffer INT 
    ,@p_Price DECIMAL(20,2) 
	,@p_City VARCHAR(100)
    ,@p_Administration VARCHAR (30) 
	,@p_Images VARCHAR(MAX)
    ,@p_Comments VARCHAR(2000) 
    ,@p_Stratum INT
	,@p_Address VARCHAR(1000) 
    ,@p_Neighborhood VARCHAR(500) 
	,@p_AgentId INT 
    ,@p_Latitude VARCHAR(30) 
	,@p_Longitude VARCHAR(30) 
	,@p_Video VARCHAR(1000) 
	,@p_ResponseUrl VARCHAR(1000) 
	,@p_Amenities VARCHAR(MAX) 
 )
 AS
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION 
			INSERT INTO  [dbo].[Tbl_M2_RealState]
				(	
				[IdAsociado] 
				,[ResourceId]
				,[RealEstateType] 
				,[RealEstateOffer]
				,[Price] 
				,[City] 
				,[Administration] 
				,[Images]
				,[Comments] 
				,[Stratum] 
				,[Address] 
				,[Neighborhood] 
				,[AgentId] 
				,[Latitude] 
				,[Longitude] 
				,[Video]
				,[ResponseUrl] 
				,[Amenities]
				)
				VALUES
				(	
				 @p_IdAsociado 
				,@p_ResourceId
				,@p_RealEstateType 
				,@p_RealEstateOffer
				,@p_Price 
				,@p_City 
				,@p_Administration 
				,@p_Images
				,@p_Comments 
				,@p_Stratum 
				,@p_Address 
				,@p_Neighborhood 
				,@p_AgentId 
				,@p_Latitude 
				,@p_Longitude 
				,@p_Video
				,@p_ResponseUrl 
				,@p_Amenities
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