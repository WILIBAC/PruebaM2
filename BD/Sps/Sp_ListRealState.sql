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
	@IdAsociado varchar
)
AS
BEGIN
    BEGIN TRY
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
		where [IdAsociado] = @IdAsociado
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
exec dbo.Sp_ListRealState ''