import { Component, OnInit } from '@angular/core';
import { ShopLoginService } from './service/shop-login.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{
  title = 'wixit-entreprise';

  constructor(private _auth: ShopLoginService) {

  }

  ngOnInit() {
    this._auth.autoLogin();
  }
}
