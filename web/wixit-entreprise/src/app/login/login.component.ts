import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, NgForm } from "@angular/forms";
import { ShopLoginService, UserShopData } from '../service/shop-login.service';
import { Router } from '@angular/router';
import { Shop } from '../model/shop';
import { BehaviorSubject, Observable, Subscription } from 'rxjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  isLoading = false;
  error = null;
  BASE_URL = "http://localhost:4000";
  constructor(private _login: ShopLoginService, private _router: Router) {
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
  }

  ngOnInit(): void {
  }

  onSubmit(form: NgForm) {

    const id = form.value.id
    const password = form.value.password
    this.isLoading = true

    let authObs: Observable<UserShopData>;
    this.isLoading = true;
    if (!form.valid) {
      return;
    }
    else {
      authObs = this._login.GetLogin(id, password)//.subscribe(data => {
      //     console.log(data["request"])
      //     if (data["request"] == 1) {
      //       this.isLoading = false;
      //       console.log(data["response"])
      //        const shopUser = new Shop(data["response"]["identifier"], data["response"]["idShop"], data["response"]["name"], data["response"]["image"], data["response"]["adress"], data["response"]["number"], data["response"]["logo"], data["response"]["informations"], data["response"]["latitude"], data["response"]["longitude"]);
      //       var LocalStorageManager = {
      //         setValue: function(key, value) {
      //           window.localStorage.setItem(key, JSON.stringify(value));
      //         },
      //         getValue: function(key) {
      //           try {
      //             return JSON.parse(window.localStorage.getItem(key));
      //           }
      //           catch (e) {

      //           }
      //         }
      //       }
      //       LocalStorageManager.setValue("shopUser", shopUser);
      //       console.log(shopUser)



      //       //this._router.navigate(['/dashboard']);
      //     }
      //   },
      //     error => {
      //       console.log(error["error"]["request"])
      //       if (error["error"]["request"] == 0) {
      //         this.error = error["error"]["result"]
      //         this.isLoading = false;
      //       }
      //       else {
      //         this.error = "Erreur interne veuillez réessayer ultérieurement"
      //         this.isLoading = false;
      //       }
      //     })
      // }
      authObs.subscribe(
        resData => {
          console.log(resData);
          this._router.navigate(['/dashboard']);
        },
        error => {
          console.log(error["error"]["request"])
          if (error["error"]["request"] == 0) {
            this.error = error["error"]["result"]
            this.isLoading = false;
          }
          else {
            this.error = "Erreur interne veuillez réessayer ultérieurement"
            this.isLoading = false;
          }
        })
      form.reset();
    }
  }
}
