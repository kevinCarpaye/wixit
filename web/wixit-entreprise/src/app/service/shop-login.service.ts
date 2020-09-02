import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, Subject, BehaviorSubject } from 'rxjs';
import {  catchError, tap } from 'rxjs/operators'
import { Shop } from '../model/shop';
import { Router } from '@angular/router';


export interface UserShopData {
  request: number;
  result: string;
  response: Response;
}

interface Response {
  identifier: string;
  idShop: number;
  name: string;
  image: string,
  adress: string,
  number: number,
  logo: string,
  informations: string,
  latitude: number,
  longitude: number
}

@Injectable({
  providedIn: 'root'
})
export class ShopLoginService {

  shop = new BehaviorSubject<Shop>(null);

  private _loginUrl = 'http://localhost:4000/api/shopLogin'

  constructor(private _http: HttpClient, private _route: Router) {
  }

  GetLogin(id: string, password: string): Observable<UserShopData> {
    let params = new HttpParams().append("id", id).append("password", password)
    return this._http.get<UserShopData>(this._loginUrl, 
      { params: params }
      ).pipe(
        tap(resData => {
          console.log(resData)
          const shop = new Shop(resData.response.identifier, resData.response.idShop, resData.response.name, resData.response.image, resData.response.adress, resData.response.number, resData.response.logo, resData.response.informations, resData.response.latitude, resData.response.longitude)
          this.shop.next(shop);
          var LocalStorageManager = {
            setValue: function (key, value) {
              window.localStorage.setItem(key, JSON.stringify(value));
            },
            getValue: function (key) {
              try {
                return JSON.parse(window.localStorage.getItem(key));
              }
              catch (e) {

              }
            }
          }
          LocalStorageManager.setValue("userShop", shop)
        })
      );
  }

  autoLogin() {
    var LocalStorageManager = {
      setValue: function (key, value) {
        window.localStorage.setItem(key, JSON.stringify(value));
      },
      getValue: function (key) {
        try {
          return JSON.parse(window.localStorage.getItem(key));
        }
        catch (e) {

        }
      }
    }
    const shop = LocalStorageManager.getValue("userShop");
    if (!shop) {
      console.log("app-component returned" )
      return
    }
    console.log("app-component : " + shop.nameShop)
    const userShop = new Shop(shop.idShopUser, shop.idShop, shop.nameShop, shop.imageShop, shop.adressShop, shop.numberShop, shop.logoShop, shop.informationsShop, shop.latitudeShop, shop.longitudeShop)
    this.shop.next(userShop);
  }

  Logout() {
    this.shop.next(null);
    localStorage.removeItem('userShop');
    this._route.navigate(['home']);
    console.log("deco")
  }
}
