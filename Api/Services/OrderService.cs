using Api.Abstractions;
using Api.Models;

namespace Api.Services;

public class OrderService : IOrderService
{
    private readonly IOrderRepository _orderRepository;

    public OrderService(IOrderRepository orderRepository)
    {
        _orderRepository = orderRepository;
    }

    public List<Order> GetOrdersByCompanyId(int companyId)
    {
        return _orderRepository.GetOrdersByCompanyId(companyId);
    }
}

