IF OBJECT_ID('dbo.Sp_ListNomenclatures') IS NOT NULL
    BEGIN 
    DROP PROCEDURE  dbo.Sp_ListNomenclatures
IF OBJECT_ID('dbo.Sp_ListNomenclatures') IS NOT NULL
    PRINT '<<<< FAILED DROPPING PROCEDURE  dbo.Sp_ListNomenclatures >>>>'
ELSE 
    PRINT '<<<< DROPPED PROCEDURE  dbo.Sp_ListNomenclatures >>>>'
END 
GO

CREATE PROCEDURE  dbo.Sp_ListNomenclatures
AS
BEGIN
    BEGIN TRY
        select IdNomenclature, 
                Nomenclature,
                Abbreviation
        from [dbo].Tbl_Nomenclatures 
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
exec dbo.Sp_ListNomenclatures