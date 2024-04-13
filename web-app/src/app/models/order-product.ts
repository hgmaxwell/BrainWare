import { Product } from "./product";

export interface OrderProduct {
    orderProductId: number;
    product: Product;
    quantity: number;
    salePrice: number;
}