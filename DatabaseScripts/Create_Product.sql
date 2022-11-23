SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Duy
-- Create date: 11/11/2022
-- Description:	Create Product
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[Create_Product]
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
		insert into Products(Sku,Price,IsActive,ImageUrl,CreatedAt,ViewCount,RateTotal,RateCount)
		values(@sku,@price,@isActive,@imageUrl,getdate(),0,0,0)
		set @id = SCOPE_IDENTITY()

		insert into ProductTranslations(ProductId,LanguageId,Content,Name,Description,SeoDescription,SeoAlias,SeoTitle,SeoKeyword)
		values(@id,@language,@content,@name,@description,@seoDescription,@seoAlias,@seoTitle,@seoKeyword)
	commit
	end try
	begin catch
		rollback
			declare @ErrorMessage VARCHAR(2000)
			select @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
			raiserror(@ErrorMessage,16,1)
	end catch

	
END