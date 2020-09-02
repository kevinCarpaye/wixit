import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { DeleteArticle } from '../model/delete-article';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DeleteArticleService {

  private _updateArticleUrl = 'http://localhost:4000/api/deleteArticleByShop'

  constructor( private _http: HttpClient) {

   }
   
   DeleteArticle(change: DeleteArticle): Observable<DeleteArticle> {
    return this._http.put<DeleteArticle>(this._updateArticleUrl, change);
  }
}
