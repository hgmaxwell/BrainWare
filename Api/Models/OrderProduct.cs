namespace Api.Models;

public class OrderProduct
{
    public int OrderProductId { get; set; }

    public Product Product { get; set; }

    public int Quantity { get; set; }

    public decimal SalePrice { get; set; }
}
