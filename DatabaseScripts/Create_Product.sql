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
@sku varchar(50),
@price float,
@isActive bit,
@imageUrl nvarchar(255),
@id int output
AS
BEGIN
	SET NOCOUNT ON;

   insert into Products(Sku,Price,IsActive,ImageUrl,CreatedAt,ViewCount,RateTotal,RateCount)
   values(@sku,@price,@isActive,@imageUrl,getdate(),0,0,0)

   set @id = SCOPE_IDENTITY()
END