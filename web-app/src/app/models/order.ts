import { OrderProduct } from "./order-product";

export interface Order {
    orderId: number;
    companyName: string;
    description: string;
    orderDate: Date;
    orderTotal: number;
    orderProducts: OrderProduct[];
  }
