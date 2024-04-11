using Api.Abstractions;
using Api.Models;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NSubstitute;

namespace Api.Controllers;

[TestFixture]
public class OrderControllerShould
{
    private IOrderService service;
    private OrderController controller;

    [SetUp]
    public void Setup()
    {
        var logger = Substitute.For<ILogger<OrderController>>();
        service = Substitute.For<IOrderService>();
        controller = new (service, logger);
    }

    [Test]
    public void ReturnOrdersWhenCalledWithValidId()
    {
        //Arrange
        var companyId = 1;
        var orders = new List<Order> { new(), new() };
        service.GetOrdersByCompanyId(companyId).Returns(orders);

        // Act
        var result = controller.GetOrdersByCompanyId(companyId).Result;

        // Assert
        var okResult = result.Should().BeOfType<OkObjectResult>().Subject;
        var returnedOrders = okResult.Value.Should().BeAssignableTo<IEnumerable<Order>>().Subject;
        returnedOrders.Should().BeEquivalentTo(orders);
    }

    [Test]
    public void Return500WhenExceptionIsThrown()
    {
        // Arrange
        var companyId = 1;
        service.When(x => x.GetOrdersByCompanyId(companyId)).Do(x => throw new Exception());

        // Act
        var result = controller.GetOrdersByCompanyId(companyId).Result;

        // Assert
        result.Should().BeOfType<ObjectResult>().Which.StatusCode.Should().Be(500);
    }
}