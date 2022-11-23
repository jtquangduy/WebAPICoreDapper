SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Duy
-- Create date: 11/11/2022
-- Description:	Update Product
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[Update_Product]
	@name nvarchar(255),
	@description nvarchar(255),
	@content ntext,
	@seoDescription nvarchar(255),
	@seoAlias nvarchar(255),
	@seoTitle nvarchar(255),
	@seoKeyword nvarchar(255),
	@sku varchar(50),
	@price float,
	@isActive bit,
	@imageUrl nvarchar(255),
	@language varchar(5),
	@id int output
AS
BEGIN
	SET NOCOUNT ON;

	set xact_abort on;

	begin tran
	begin try
		update Products set Sku=@sku, Price = @price, IsActive = @isActive, ImageUrl = @imageUrl
		where Id=@id

		update ProductTranslations set Content=@content, Name=@name, Description=@description, SeoDescription=@seoDescription, SeoAlias= @seoAlias, SeoTitle=@seoTitle, SeoKeyword=@seoKeyword
		where ProductId=@id and LanguageId=@language

	commit
	end try
	begin catch
		rollback
			declare @ErrorMessage VARCHAR(2000)
			select @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
			raiserror(@ErrorMessage,16,1)
	end catch

	
END