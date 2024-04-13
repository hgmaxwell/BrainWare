import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Order } from '../models/order';

@Injectable({
  providedIn: 'root'
})
export class OrderService {

  constructor(private http: HttpClient) { }

  getOrdersByCompanyId(companyId: number): Observable<Order[]> {
    const url = `${environment.ordersBaseUrl}/Order/Company/${companyId}`;
    return this.http.get<Order[]>(url);
  }
}
