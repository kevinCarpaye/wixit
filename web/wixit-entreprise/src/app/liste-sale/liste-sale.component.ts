import { Component, OnInit } from '@angular/core';
import { CurrentSalesService } from '../service/sales.service';
import { Sales } from '../model/sale';
import { Router } from '@angular/router';

@Component({
  selector: 'app-liste-sale',
  templateUrl: './liste-sale.component.html',
  styleUrls: ['./liste-sale.component.scss']
})
export class ListeSaleComponent implements OnInit {

  checked = false;
  checked1 = false;
  checked2 = false;
  checked22 = false;
  BASE_URL = "http://localhost:4000";
  ListSales: Array<Sales> = new Array<Sales>();
  ListSales2: Array<Sales> = new Array<Sales>();
  filteredName = "";

  constructor(private _route: Router, private _listSale: CurrentSalesService) {
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
    const params = LocalStorageManager.getValue("userShop");
    const id = params["idShopUser"];
    console.log(id)
    this._listSale.GetCurrentSales(id).subscribe(data => {
      console.log(data)
      data["response"].forEach(element => {
        console.log(element)
        this.ListSales.push(element)
      });
    },
      error => {
        console.log(error);
      })
    this._listSale.GetOldSales(id).subscribe(data => {
      data["response"].forEach(element => {
        console.log(element)
        this.ListSales2.push(element)
      });
    },
      error => {
        console.log(error);
      })
  }

  ngOnInit(): void {
  }

  click(id, image, name, type, price_base, price, date_start, date_end) {
    let parameters = {
      "idSale": id,
      "image": this.BASE_URL + image,
      "name": name,
      "type": type,
      "price_base": price_base,
      "price": price,
      "date_start": date_start,
      "date_end": date_end
    }
    console.log(parameters)
    this._route.navigate(['updateSale', parameters])
  }

  changeInput() {
    this.checked = !this.checked
    console.log(this.checked)
  }

  changeInput2() {
    this.checked22 = !this.checked22
    console.log(this.checked22)
  }

  changeTable1() {
    this.checked1 = !this.checked1
    console.log(this.checked1)
  }

  changeTable2() {
    this.checked2 = !this.checked2
  }
}