SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Duy
-- Create date: 11/11/2022
-- Description:	Get all product with paging
-- =============================================
CREATE OR ALTER PROCEDURE Get_Product_AllPaging
	@keyword nvarchar(50),
	@categoryId int,
	@pageIndex int,
	@pageSize int,
	@language varchar(5),
	@totalRow int output
AS
BEGIN
	SET NOCOUNT ON;

	select @totalRow = count(*) 
	from Products p inner join ProductTranslations pt on p.Id = pt.ProductId
	where (@keyword is null or p.Sku like @keyword +'%') and p.IsActive = 1

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
	where (@keyword is null or p.Sku like @keyword +'%')
	and pt.LanguageId = @language
	and p.IsActive = 1
	order by p.CreatedAt desc
	offset (@pageIndex - 1) * @pageSize rows
	fetch next @pageSize row only

END
GO