import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { OrderService } from '../../services/order.service';
import { Order } from 'src/app/models/order';

@Component({
  selector: 'web-app-orders',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './orders.component.html',
  styleUrl: './orders.component.css',
})
export class OrdersComponent implements OnInit {
  orders: Order[] = [];

  constructor(private orderService: OrderService) { }

  ngOnInit(): void {
    this.loadOrders(1);
  }

  loadOrders(companyId: number){
    this.orderService.getOrdersByCompanyId(companyId).subscribe(
      (data) => {
        this.orders = data;
      },
      (error) => {
        console.error('Error fetching customer orders:', error);
      }
    )
  }
}

