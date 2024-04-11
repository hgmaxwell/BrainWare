using Api.Models;

namespace Api.Abstractions;

public interface IOrderService
{
    List<Order> GetOrdersByCompanyId(int companyId);
}