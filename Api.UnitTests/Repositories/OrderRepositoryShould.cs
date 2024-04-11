using Api.Abstractions;
using Api.Models;
using FluentAssertions;
using NSubstitute;
using System.Data;
using System.Data.SqlClient;

namespace Api.Repositories;

[TestFixture]
public class OrderRepositoryShould
{
    internal const string ProcGetOrdersByCompanyId = "[dbo].[GetOrderProductsByCompanyId]";

    private OrderRepository repo;
    private IDatabaseAdapter database;

    [SetUp]
    public void Setup()
    {
        database = Substitute.For<IDatabaseAdapter>();
        repo = new OrderRepository(database);
    }

    [Test]
    public void ReturnOrdersWithValidCompanyId()
    {
        // Arrange
        var companyId = 1;
        var expectedOrders = new List<Order>
        {
            new()
            {
                OrderId = 1, 
                CompanyName = "Company1", 
                Description = "Description1", 
                OrderDate = DateTime.Now,
                OrderTotal = 3.50m,
                OrderProducts = new List<OrderProduct>
                {
                    new()
                    {
                        OrderProductId = 1,
                        Quantity = 1,
                        SalePrice = 3.50m,
                        Product = new Product
                        {
                            ProductId = 1,
                            ProductName = "Product1"
                        }
                    }
                }
            },
            new()
            {
                OrderId = 2, 
                CompanyName = "Company2", 
                Description = "Description2", 
                OrderDate = DateTime.Now, 
                OrderTotal = 3.50m,
                OrderProducts = new List<OrderProduct>
                {
                    new()
                    {
                        OrderProductId = 2,
                        Quantity = 1,
                        SalePrice = 3.50m,
                        Product = new Product
                        {
                            ProductId = 1,
                            ProductName = "Product1"
                        }
                    }
                }
            }
        };

        var dataTable = new DataTable();
        dataTable.Columns.Add("OrderId", typeof(int));
        dataTable.Columns.Add("CompanyName", typeof(string));
        dataTable.Columns.Add("Description", typeof(string));
        dataTable.Columns.Add("OrderDate", typeof(DateTime));
        dataTable.Columns.Add("OrderProductId", typeof(int));
        dataTable.Columns.Add("ProductId", typeof(int));
        dataTable.Columns.Add("ProductName", typeof(string));
        dataTable.Columns.Add("Quantity", typeof(int));
        dataTable.Columns.Add("SalePrice", typeof(decimal));

        foreach (var order in expectedOrders)
        {
            var row = dataTable.NewRow();
            row["OrderId"] = order.OrderId;
            row["CompanyName"] = order.CompanyName;
            row["Description"] = order.Description;
            row["OrderDate"] = order.OrderDate;

            foreach (var orderProduct in order.OrderProducts)
            {
                row["OrderProductId"] = orderProduct.OrderProductId;
                row["ProductId"] = orderProduct.Product.ProductId;
                row["ProductName"] = orderProduct.Product.ProductName;
                row["Quantity"] = orderProduct.Quantity;
                row["SalePrice"] = orderProduct.SalePrice;
            }

            dataTable.Rows.Add(row);
        }

        database.ExecuteStoredProcedure(ProcGetOrdersByCompanyId, Arg.Any<SqlParameter[]>()).Returns(dataTable);

        // Act
        var result = repo.GetOrdersByCompanyId(companyId);

        // Assert
        result.Should().BeEquivalentTo(expectedOrders);
    }
}