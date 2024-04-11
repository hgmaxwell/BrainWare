using Api.Abstractions;
using Api.Models;
using FluentAssertions;
using NSubstitute;

namespace Api.Services;

[TestFixture]
public class OrderServiceShould
{
    private OrderService service;
    private IOrderRepository repository;

    [SetUp]
    public void Setup()
    {
        repository = Substitute.For<IOrderRepository>();
        service = new OrderService(repository);
    }

    [Test]
    public void ReturnOrdersWithValidCompanyId()
    {
        // Arrange
        var companyId = 1;
        var orders = new List<Order> { new(), new() };
        repository.GetOrdersByCompanyId(companyId).Returns(orders);

        // Act
        var result = service.GetOrdersByCompanyId(companyId);

        // Assert
        var returnedOrders = result.Should().BeAssignableTo<IEnumerable<Order>>().Subject;
        returnedOrders.Should().BeEquivalentTo(orders);
    }
}