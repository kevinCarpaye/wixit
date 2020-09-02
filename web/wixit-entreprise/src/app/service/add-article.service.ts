import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AddArticle } from '../model/add-article';

@Injectable({
  providedIn: 'root'
})
export class AddArticleService {

  private _addArticleUrl = 'http://localhost:4000/api/addArticleByShop'

  constructor( private _http: HttpClient) {

   }

   AddArticle(article: AddArticle): Observable<AddArticle> {
    return this._http.post<AddArticle>(this._addArticleUrl, article);
  }
}
