SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Duy
-- Create date: 11/11/2022
-- Description:	Select all records
-- =============================================
CREATE OR ALTER PROCEDURE Get_Product_All
AS
BEGIN
	SET NOCOUNT ON;

    select Id,Sku,Price,DiscountPrice,ImageUrl,CreatedAt,IsActive,ViewCount from Products
END