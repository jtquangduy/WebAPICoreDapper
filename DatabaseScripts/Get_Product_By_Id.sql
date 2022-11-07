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
@id int
AS
BEGIN
	SET NOCOUNT ON;

    select Id,Sku,Price,DiscountPrice,ImageUrl,CreatedAt,IsActive,ViewCount from Products
	where Id = @id
END