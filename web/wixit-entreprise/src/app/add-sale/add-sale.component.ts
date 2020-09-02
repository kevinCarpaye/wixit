import { Component, OnInit } from '@angular/core';
import { Article } from '../model/article';
import { ArticlesService } from '../service/articles.service';
import { NgForm } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { AddSaleService } from '../service/add-sale.service';
import { AddSale } from '../model/add-sale';

@Component({
  selector: 'app-add-sale',
  templateUrl: './add-sale.component.html',
  styleUrls: ['./add-sale.component.scss'],
  providers: [DatePipe]
})
export class AddSaleComponent implements OnInit {

  ListArticle: Array<Article> = new Array<Article>()
  BASE_URL = "http://localhost:4000";
  filteredName = "";
  idPrice = 0;
  checked = false;
  name = null;
  barcode = null;
  type = null;
  price_base = null;
  price = null;
  stock = null;
  date_start = null;
  date_end = null;
  error = "";
  message = "";
  isLoading = false;

  constructor(private _articles: ArticlesService, private _addSale: AddSaleService, private datePipe: DatePipe) {
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
     const params = LocalStorageManager.getValue("userShop");
     const idUser = params["idShopUser"];
    console.log(idUser);
    this._articles.GetArticles(idUser).subscribe((data) => {
      console.log(data);
      console.log(data["resp:"])
      data["resp:"].forEach(element => {
        console.log(element)
        this.ListArticle.push(element)
      });
    })
   }

  ngOnInit(): void {
  }

  click(idPrice, name, barcode, type, price_base, stock) {
    this.idPrice = idPrice;
    this.name = name;
    this.barcode = barcode;
    this.type = type;
    this.price_base = price_base;
    this.stock = stock;
  }

  onSubmit(form: NgForm) {
    if (this.idPrice === null || this.name === null || this.type === null) {
      console.log("Vous n'avez pas sélectionné l'article")
      this.error = "Vous n'avez pas sélectionné l'article"
      return
    }

    if (this.price_base === null || this.date_start === null || this.date_end === null) {
      console.log("Paramètres manquants.")
      this.error = "Paramètres manquants"
      return
    }

    if (this.price < 0) {
      this.error = "Le prix ne peut pas être inférieur à 0€"
      return
    }

    //this.datePipe.transform(new Date(), 'yyyy-MM-dd');
    let dateDebut = this.datePipe.transform("2020-05-28:0:00:00", 'yyyy-MM-dd:h:mm:ss');
    let dateActuelle = this.datePipe.transform(new Date(), 'yyyy-MM-dd:h:mm:ss');
    let debutTim = this.toTimestamp(this.date_start);
    let finTim = this.toTimestamp(this.date_end);
    let actuelleTim = this.toTimestamp("2020-05-28:23:59:59");
    let soustraction = actuelleTim - debutTim;
    console.log("date de debut: " + dateDebut)
    console.log("date actuelle: " + dateActuelle);
    console.log("date de debut : " + debutTim);
    console.log("date actuelle : " + actuelleTim);
    console.log("soustraction: " + soustraction)

    if (soustraction > 79199) {
      this.error = "La date de début ne doit pas être antérieure à la date d'aujourd'hui."
      return
    }

    if (finTim < debutTim) {
      this.error = "La date de fin ne doit pas être antérieure à la date de début."
      return
    }

    this.checked = false;
    this.error = "";
    this.isLoading = true;

    const sale = new AddSale(this.idPrice, this.price, this.date_start, this.date_end)
    this._addSale.AddSale(sale).subscribe(res => {
      this.isLoading = false
      if(res["request"] == 1) {
        this.message = res["result"];
      }
      console.log(res);
    },
    error => {
      console.log(error["error"]["request"]);
      if (error["error"]["request"] == 0) {
        this.isLoading = false
        this.error = error["error"]["result"]
      }
    })
  }

  changeTable() {
    this.checked = !this.checked;
  }

  toTimestamp(strDate){
    var datum = Date.parse(strDate);
    return datum/1000;
   }

}
