SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Duy
-- Create date: 11/11/2022
-- Description:	Select one recorrd by id 
-- =============================================
CREATE OR ALTER PROCEDURE Get_Product_By_Id
	@id int,
	@language varchar(5)
AS
BEGIN
	SET NOCOUNT ON;

    select 
		p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoAlias,
		pt.SeoDescription,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId
	from Products p inner join ProductTranslations pt on p.Id = pt.ProductId
	where Id = @id AND pt.LanguageId = @language
END