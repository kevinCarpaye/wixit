import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { LoginComponent } from '../login/login.component';
import { ShopLoginService } from '../service/shop-login.service';

@Component({
  selector: 'app-header2',
  templateUrl: './header2.component.html',
  styleUrls: ['./header2.component.scss']
})
export class Header2Component implements OnInit, OnDestroy {

  private shopSub: Subscription;
  isAuthenticated = false; 
  //LocalStorageManager = null;
  constructor(private _login: ShopLoginService) {
   }

  ngOnInit(): void {
    console.log("init header")
    this.shopSub = this._login.shop.subscribe(shop => {
      this.isAuthenticated = !!shop;
      console.log(shop)
      console.log(!shop);
      console.log(!!shop);
    });
  }

  logOut() {
    //console.log('deco')
    this._login.Logout()
  }

  ngOnDestroy() {
    this.shopSub.unsubscribe();
  }
}
