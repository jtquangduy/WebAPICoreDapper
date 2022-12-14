USE [RestAPIDapper]
GO
/****** Object:  StoredProcedure [dbo].[Delete_Product_By_Id]    Script Date: 11/7/2022 3:56:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Duy
-- Create date: 11/11/2022
-- Description:	Delete one record by id 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[Delete_Product_By_Id]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SET xact_abort on;
	Begin tran
		begin try
			delete from Products where Id = @id
			delete from ProductTranslations where ProductId = @id 
		commit
	end try
		begin catch
			rollback
			declare @ErrorMessage VARCHAR(2000)
			select @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
			raiserror(@ErrorMessage,16,1)
		end catch

END