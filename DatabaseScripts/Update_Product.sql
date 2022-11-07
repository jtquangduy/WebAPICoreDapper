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
@id int,
@sku varchar(50),
@price float,
@isActive bit,
@imageUrl nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	update Products set Sku=@sku, Price = @price, IsActive = @isActive, ImageUrl = @imageUrl
	where Id=@id
END