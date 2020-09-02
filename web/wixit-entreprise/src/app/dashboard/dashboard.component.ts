import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DashboardService } from '../service/dashboard.service';
import { Shop } from '../model/shop';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  idShop = null;
  idShopUser = null;
  name = null;
  image = null;
  adress = null;
  number = null;
  informations = null;
  logo = null;
  latitude = null;
  longitude = null;
  number_article = 0;
  number_sales = 0;
  number_current_sales = 0;
  number_redirection = 0;
  number_save = 0;
  number_route = 0;

  constructor(private _router: ActivatedRoute, private _dashboard: DashboardService) {
    var LocalStorageManager = {
      setValue: function(key, value) {
        window.localStorage.setItem(key, JSON.stringify(value));
      },
      getValue: function(key) {
        try {
          return JSON.parse(window.localStorage.getItem(key));
        }
        catch (e) {

        }
      }
    }
    var shopUser : Shop = LocalStorageManager.getValue("userShop");
    console.log("Local Storage:     " + shopUser);
    this.idShop = shopUser.idShop;
    console.log("idShop:    " + shopUser.idShop);
    this.idShopUser = shopUser.idShopUser;
    console.log("idShopUser:    " + shopUser.idShopUser);
    this.name = shopUser.nameShop;
    console.log("Name:    " + this.name);
    this.image = shopUser.imageShop;
    console.log("Image:    " + this.image);
    this.adress = shopUser.adressShop;
    console.log("Adresse:    " + this.adress);
    this.number = shopUser.numberShop;
    console.log("number:   " + this.number);
    this.informations = shopUser.informationsShop;
    console.log("informations:   " + this.informations);
    this.logo = shopUser.logoShop;
    console.log("logo:   " + this.logo);
    this.latitude = shopUser.latitudeShop;
    console.log("latitude:   " + this.latitude);
    this.longitude = shopUser.longitudeShop;
    console.log("longitude:   " + this.longitude);

    this._dashboard.GetDashboard(this.idShopUser).subscribe(data => {
      this.number_article = data["response"]["number_articles"];
      this.number_sales = data["response"]["number_sales"];
      this.number_current_sales = data["response"]["number_current_sales"];
      this.number_redirection = data["response"]["redirection"];
      this.number_save = data["response"]["save"];
      this.number_route = data["response"]["route"];
      console.log(this.number_redirection + " " + this.number_save + " " + this.number_route);
    },
    error => {

    })
   }

  ngOnInit(): void {
    
  }

}
