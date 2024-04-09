
INSERT INTO Company (Name) VALUES ('BrainWare Company')

INSERT INTO Product (Name, Price) VALUES ('Pipe fitting', 1.23)
INSERT INTO Product (Name, Price) VALUES ('10" straight', 2.00)
INSERT INTO Product (Name, Price) VALUES ('Quarter turn', 0.75)
INSERT INTO Product (Name, Price) VALUES ('5" straight', 1.1)
INSERT INTO Product (Name, Price) VALUES ('2" stright', 0.90)

INSERT INTO [Order] (Description, CompanyId, OrderDate) VALUES ('Our first order.', 1, GETDATE())
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (1, 1, 1.23, 10)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (1, 3, 1.00, 3)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (1, 4, 1.1, 22)

INSERT INTO [Order] (Description, CompanyId, OrderDate) VALUES ('Our Second order.', 1, GETDATE())
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (2, 1, 1.23, 10)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (2, 3, 1.00, 3)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (2, 2, 2, 13)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (2, 5, 0.9, 3)


INSERT INTO [Order] (Description, CompanyId, OrderDate) VALUES ('Our third order.', 1, GETDATE())
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (3, 1, 1.23, 10)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (3, 2, 2.00, 7)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (3, 3, 0.75, 13)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (3, 4, 1.1, 5)
INSERT INTO [OrderProduct] (OrderId, ProductId, SalePrice, Quantity) VALUES (3, 5, 0.9, 3)