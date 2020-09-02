import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UpdateArticle } from '../model/update-article';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UpdateArticleService {

  private _updateArticleUrl = 'http://localhost:4000/api/updateArticleByShop'

  constructor( private _http: HttpClient) {

   }

   UpdateArticle(change: UpdateArticle): Observable<UpdateArticle> {
    return this._http.put<UpdateArticle>(this._updateArticleUrl, change);
  }
}
