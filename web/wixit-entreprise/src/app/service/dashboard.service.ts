import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Dashboard } from '../model/dashboard';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  private _typesUrl = 'http://localhost:4000/api/dashboard'

  constructor( private _http: HttpClient) {

   }

   GetDashboard(id: string): Observable<Dashboard[]> {
     let parameters = {"id" : id}
    return this._http.get<Dashboard[]>(this._typesUrl, {params: parameters});
  }
}
