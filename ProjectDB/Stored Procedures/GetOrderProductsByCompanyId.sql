CREATE PROCEDURE [dbo].[GetOrderProductsByCompanyId]
	@companyId INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT c.Name AS CompanyName,
		   o.OrderId,
		   o.Description,
		   o.OrderDate,
		   p.ProductId,
		   p.Name AS ProductName,
		   op.OrderProductId,
		   op.SalePrice,
		   op.Quantity
	FROM [dbo].[Company] c
	INNER JOIN [dbo].[Order] o ON o.CompanyId = c.CompanyId AND o.IsDeleted = 0
	INNER JOIN [dbo].[OrderProduct] op ON op.OrderId = o.OrderId AND op.IsDeleted = 0
	INNER JOIN [dbo].[Product] p ON p.ProductId = op.ProductId
	WHERE c.CompanyId = @companyId
	ORDER BY o.OrderDate DESC, ProductName ASC
END