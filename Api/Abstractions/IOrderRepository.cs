using Api.Models;

namespace Api.Abstractions;

public interface IOrderRepository
{
    List<Order> GetOrdersByCompanyId(int companyId);
}