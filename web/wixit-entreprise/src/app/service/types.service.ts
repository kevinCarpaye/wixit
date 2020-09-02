import { Injectable, Type } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Types } from '../model/type';

@Injectable({
  providedIn: 'root'
})
export class TypesService {

  private _typesUrl = 'http://localhost:4000/api/fetchType'

  constructor( private _http: HttpClient) {

   }

   GetArticles(): Observable<Types[]> {
    return this._http.get<Types[]>(this._typesUrl);
  }
}
