import { ComponentFixture, TestBed } from '@angular/core/testing';
import { OrdersComponent } from './orders.component';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { OrderService } from '../../services/order.service';
import { Order } from 'src/app/models/order';
import { environment } from 'src/environments/environment';

describe('OrdersComponent', () => {
  let component: OrdersComponent;
  let fixture: ComponentFixture<OrdersComponent>;
  let httpTestingController: HttpTestingController;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrdersComponent, HttpClientTestingModule],
      declarations: [],
      providers: [OrderService]
    }).compileComponents();

    httpTestingController = TestBed.inject(HttpTestingController);
    fixture = TestBed.createComponent(OrdersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should render title', () => {
    const fixture = TestBed.createComponent(OrdersComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain(
      'BrainWare Orders'
    );
  });

  it('should load orders for a given company ID', () => {
    const companyId = 2;
    const mockOrders: Order[] = [];
  
    component.loadOrders(companyId);
  
    const req = httpTestingController.expectOne(
      `${environment.ordersBaseUrl}/Order/Company/${companyId}`
    );
    expect(req.request.method).toBe('GET'); 
    req.flush(mockOrders); 
  
    expect(component.orders).toEqual(mockOrders);
  });
  
  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
