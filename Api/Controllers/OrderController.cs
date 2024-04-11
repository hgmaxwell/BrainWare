using Api.Abstractions;
using Api.Models;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class OrderController : ControllerBase
{
    private readonly IOrderService _orderService;
    private readonly ILogger<OrderController> _logger;

    public OrderController(IOrderService orderService, ILogger<OrderController> logger)
    {
        _orderService = orderService;
        _logger = logger;
    }

    [HttpGet("Company/{companyId}")]
    [ProducesResponseType((int)HttpStatusCode.OK)]
    public ActionResult<IEnumerable<Order>> GetOrdersByCompanyId(int companyId)
    {
        try
        {
            var orders = _orderService.GetOrdersByCompanyId(companyId);
            return Ok(orders);
        }
        catch (Exception ex)
        {
            // Log the exception
            _logger.LogError(ex, "Failed to get orders for company ID: {CompanyId}", companyId);
            return StatusCode(500, "An error occurred while processing your request.");
        }
    }
}

