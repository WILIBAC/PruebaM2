IF OBJECT_ID('dbo.Sp_ListRealState') IS NOT NULL
    BEGIN 
    DROP PROCEDURE  dbo.Sp_ListRealState
IF OBJECT_ID('dbo.Sp_ListRealState') IS NOT NULL
    PRINT '<<<< FAILED DROPPING PROCEDURE  dbo.Sp_ListRealState >>>>'
ELSE 
    PRINT '<<<< DROPPED PROCEDURE  dbo.Sp_ListRealState >>>>'
END 
GO

CREATE PROCEDURE  dbo.Sp_ListRealState
(
	@IdAsociado varchar(50),
	@p_RealStateType Int,
	@p_RealSatetOffer int,
	@p_Address varchar(max)
)
AS
BEGIN
    BEGIN TRY

	IF @p_RealStateType = 0
		SET @p_RealStateType = NULL
	IF @p_RealSatetOffer = 0
		SET @p_RealSatetOffer = NULL
	IF @p_Address = '' or @p_Address = '0'
		SET @p_Address = NULL
        select [Id]
      ,[IdAsociado]
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
      ,[logDate]
       from [dbo].Tbl_M2_RealState
		where ([IdAsociado] = @IdAsociado)
		AND (@p_RealStateType IS NULL OR [RealEstateType] = @p_RealStateType)
		AND (@p_RealSatetOffer IS NULL OR [RealEstateOffer] = @p_RealSatetOffer)
		AND (@p_Address IS NULL OR [Address] = @p_Address)
    END TRY
	BEGIN CATCH
		DECLARE	@ErrorMessage VARCHAR(4000);
        DECLARE	@ErrorSeverity INT;
        DECLARE	@ErrorState INT;

        SELECT	@ErrorMessage =ERROR_MESSAGE(),
				@ErrorSeverity=ERROR_SEVERITY(),
				@ErrorState=ERROR_STATE();
        RAISERROR(
            @ErrorMessage,
            @ErrorSeverity,
            @ErrorState
            );
	END CATCH
end
GO
