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
ALTER   PROCEDURE [dbo].[Delete_Product_By_Id]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	delete from Products where Id = @id
END