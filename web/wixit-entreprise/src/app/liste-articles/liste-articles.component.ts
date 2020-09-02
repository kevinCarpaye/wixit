import { Component, OnInit } from '@angular/core';
import { ArticlesService } from '../service/articles.service';
import { Article } from '../model/article';
import { Router } from '@angular/router';


@Component({
  selector: 'app-liste-articles',
  templateUrl: './liste-articles.component.html',
  styleUrls: ['./liste-articles.component.scss']
})

export class ListeArticlesComponent implements OnInit {

  ListArticle: Array<Article> = new Array<Article>()
  BASE_URL = "http://localhost:4000";
  checked = false;
  filteredName = "";

  constructor(private _articles: ArticlesService, private _route: Router) { 
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

  click(image, name, barcode, desciption, type, idPrice, price_base, stock) {
    let parameters = {
      "image": this.BASE_URL + image,
      "name": name,
      "barcode": barcode,
      "description": desciption,
      "type": type,
      "idPrice": idPrice,
      "price_base": price_base,
      "stock": stock,
    }
    console.log(parameters)
    this._route.navigate(['updateArticle', parameters])
  }

  changeInput() {
    this.checked = !this.checked
    console.log(this.checked)
  }
}
