import { TestBed } from '@angular/core/testing';
import { OrderService } from './order.service';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { environment } from 'src/environments/environment';
import { of } from 'rxjs';
import { Order } from '../models/order';

describe('OrderService', () => {
  let service: OrderService;
  let httpTestingController: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [OrderService]
    });
    service = TestBed.inject(OrderService);
    httpTestingController = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpTestingController.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should fetch orders by company ID', () => {
    const companyId = 1;
    const expectedUrl = `${environment.ordersBaseUrl}/Order/Company/${companyId}`;
    const mockOrders: Order[] = [];
    
    service.getOrdersByCompanyId(companyId).subscribe((orders) => {
      expect(orders).toEqual(mockOrders);
    });

    const req = httpTestingController.expectOne(expectedUrl);
    expect(req.request.method).toBe('GET');
    req.flush(mockOrders);
  });
});
