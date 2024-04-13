import { RouterModule, Routes } from '@angular/router';
import { OrdersComponent } from './core/orders/orders.component';
import { NgModule } from '@angular/core';

export const appRoutes: Routes = [
    { path: '', component: OrdersComponent }
];

@NgModule({
    imports: [RouterModule.forRoot(appRoutes)],
    exports: [RouterModule],
  })
  export class AppRoutingModule {}
