import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Sales } from '../model/sale';

@Injectable({
  providedIn: 'root'
})
export class CurrentSalesService {
  private _currentSalesUrl = 'http://localhost:4000/api/currentSales'
  private _oldSalesUrl = 'http://localhost:4000/api/oldSales'

  constructor(private _http: HttpClient) { 
  }

  GetCurrentSales(id: string): Observable<Sales[]> {
    let headers = new HttpHeaders().append('Content-Type', 'application/json');
    let params = new HttpParams().append("id",id);
    return this._http.get<Sales[]>(this._currentSalesUrl, {headers: headers, params: params});
  }

  GetOldSales(id: string): Observable<Sales[]> {
    let headers = new HttpHeaders().append('Content-Type', 'application/json');
    let params = new HttpParams().append("id",id);
    return this._http.get<Sales[]>(this._oldSalesUrl, {headers: headers, params: params});
  }
}
