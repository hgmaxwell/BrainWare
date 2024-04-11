using Api.Abstractions;
using Api.Models;
using System.Data;
using System.Data.SqlClient;

namespace Api.Repositories;

public class OrderRepository : IOrderRepository
{
    internal const string ProcGetOrdersByCompanyId = "[dbo].[GetOrderProductsByCompanyId]";

    private readonly IDatabaseAdapter _dbAdapter;

    public OrderRepository(IDatabaseAdapter dbAdapter)
    {
        _dbAdapter = dbAdapter;
    }

    public List<Order> GetOrdersByCompanyId(int companyId)
    {
        var parameters = new SqlParameter[]
        {
            new("@companyId", companyId)
        };

        var dataTable = _dbAdapter.ExecuteStoredProcedure(ProcGetOrdersByCompanyId, parameters);

        var orders = new Dictionary<int, Order>();

        foreach (DataRow row in dataTable.Rows)
        {
            var orderId = Convert.ToInt32(row["OrderId"]);

            if (!orders.TryGetValue(orderId, out var order))
            {
                order = new Order
                {
                    OrderId = orderId,
                    CompanyName = Convert.ToString(row["CompanyName"]),
                    Description = Convert.ToString(row["Description"]),
                    OrderDate = Convert.ToDateTime(row["OrderDate"]),
                    OrderProducts = new List<OrderProduct>()
                };
                orders.Add(orderId, order);
            }

            var orderProduct = new OrderProduct
            {
                OrderProductId = Convert.ToInt32(row["OrderProductId"]),
                Product = new Product
                {
                    ProductId = Convert.ToInt32(row["ProductId"]),
                    ProductName = Convert.ToString(row["ProductName"])
                },
                Quantity = Convert.ToInt32(row["Quantity"]),
                SalePrice = Convert.ToDecimal(row["SalePrice"])
            };

            order.OrderProducts.Add(orderProduct);
            order.OrderTotal += orderProduct.Quantity * orderProduct.SalePrice;
        }

        return orders.Values.ToList();
        ;
    }
}
