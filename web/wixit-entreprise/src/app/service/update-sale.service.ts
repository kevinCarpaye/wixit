import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UpdateSale } from '../model/update-sale';
import { Observable } from 'rxjs';
import { DeleteSale } from '../model/delate-sale';

@Injectable({
  providedIn: 'root'
})
export class UpdateSaleService {

  private _updateArticleUrl = 'http://localhost:4000/api/updateSaleByShop'
  private _deleteArticleUrl = 'http://localhost:4000/api/deleteSaleByShop'

  constructor( private _http: HttpClient) {
   }

   UpdateSale(change: UpdateSale): Observable<UpdateSale> {
    return this._http.put<UpdateSale>(this._updateArticleUrl, change);
  }

  DeleteSale(sale: DeleteSale): Observable<DeleteSale> {
    return this._http.put<DeleteSale>(this._deleteArticleUrl, sale);
  }
}
