import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AddSale } from '../model/add-sale';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AddSaleService {

  private addSaleUrl = 'http://localhost:4000/api/addSaleByShop';

  constructor(private _http: HttpClient) {
    
   }

   AddSale(sale: AddSale): Observable<AddSale> {
    return this._http.post<AddSale>(this.addSaleUrl, sale)
   }
}
