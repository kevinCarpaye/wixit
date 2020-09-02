import { Injectable } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Article } from '../model/article';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ArticlesService {

  private _articlesUrl = 'http://localhost:4000/api/allArticlesByShop'
  
  constructor(private _http: HttpClient) { 
  }

  GetArticles(id: string): Observable<Article[]> {
    let headers = new HttpHeaders().append('Content-Type', 'application/json');
    let params = new HttpParams().append("id",id)
    return this._http.get<Article[]>(this._articlesUrl, {headers: headers, params: params});
  }
}
