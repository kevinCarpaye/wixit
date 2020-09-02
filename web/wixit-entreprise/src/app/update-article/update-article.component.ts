import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgForm } from '@angular/forms';
import { UpdateArticleService } from '../service/update-article.service';
import { UpdateArticle } from '../model/update-article';
import { DeleteArticle } from '../model/delete-article';
import { DeleteArticleService } from '../service/delete-article.service';

@Component({
  selector: 'app-update-article',
  templateUrl: './update-article.component.html',
  styleUrls: ['./update-article.component.scss']
})
export class UpdateArticleComponent implements OnInit {
  idShop = null;
  idPrice = null;
  image = null;
  name = null;
  barcode = null;
  description = null;
  type = null;
  sendPrice_base = null;
  sendStock = null;
  price_base = null;
  stock = null;
  error = "";
  message = "";
  isLoading = false;

  constructor(private _route: ActivatedRoute, private updateService: UpdateArticleService, private deleteService: DeleteArticleService) {
    this.image = _route.snapshot.paramMap.get('image');
    this.idPrice= _route.snapshot.paramMap.get('idPrice');
    this.name = _route.snapshot.paramMap.get('name');
    this.barcode = _route.snapshot.paramMap.get('barcode');
    if (_route.snapshot.paramMap.get('description').includes("")) {
      this.description = null;
    }
    else {
      this.description = _route.snapshot.paramMap.get('description');
    }
    this.type = _route.snapshot.paramMap.get('type');
    this.sendPrice_base = _route.snapshot.paramMap.get('price_base')
    this.sendStock = _route.snapshot.paramMap.get('stock')
  }

  ngOnInit(): void {
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

    let parameters = LocalStorageManager.getValue('userShop');
    this.idShop = parameters["idShop"];
    this.price_base = this.sendPrice_base;
    this.stock = this.sendStock;
    console.log("idShop: " + this.idShop),
    console.log("idPrice: " + this.idPrice)
  }

  update(form: NgForm) {
    console.log(this.idShop)
    console.log(this.idPrice);
    if (form.value.price_base == null || form.value.price_base == "") {
      this.error = "Le prix de base est obligatoire"
      return;
    }
    if (form.value.price_base === this.sendPrice_base && form.value.stock === this.sendStock) {
      this.error = "Aucun paramètre n'a été modifié"
      return;
    }
    this.isLoading = true;
    if (form.value.stock == null || form.value.stock == "") {
      this.stock = -1
    }
    this.error = "";
    const change = new UpdateArticle(this.idShop, this.idPrice, this.price_base, this.stock);
    this.updateService.UpdateArticle(change).subscribe(data => {
      console.log(data);
      this.isLoading = false
      if (data["request"] == 1) {
        this.message = data["result"];
      }
    },
      error => {
        console.log(error);
        if (error["error"]["request"] == 0) {
          this.isLoading = false
          this.error = error["error"]["result"]
        }
      }
    )

  }

  delete(form: NgForm) {
    this.isLoading = true;
    const article = new DeleteArticle(this.idPrice);
    this.deleteService.DeleteArticle(article).subscribe(data => {
      console.log(data);
    }, 
    error => {
      console.log(error);
    })
  }

}