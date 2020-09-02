import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgForm } from '@angular/forms';
import { UpdateSale } from '../model/update-sale';
import { UpdateSaleService } from '../service/update-sale.service';
import { DeleteSale } from '../model/delate-sale';

@Component({
  selector: 'app-update-sale',
  templateUrl: './update-sale.component.html',
  styleUrls: ['./update-sale.component.scss']
})
export class UpdateSaleComponent implements OnInit {

  idSale = null;
  name = null;
  type = null;
  sendPrice_base = null;
  price_base = null;
  sendPrice = null;
  price = null;
  sendDate_start = null;
  date_start = null;
  sendDate_end = null;
  date_end = null;
  error = null;
  message = null;
  isLoading = false;

  constructor(private _route: ActivatedRoute, private _updateSale: UpdateSaleService) {
    this.idSale = _route.snapshot.paramMap.get('idSale');
    console.log(this.idSale)
    this.name = _route.snapshot.paramMap.get('name');
    this.type = _route.snapshot.paramMap.get('type');
    this.sendPrice_base = _route.snapshot.paramMap.get('price_base');
    this.price_base = this.sendPrice_base;
    this.sendPrice = _route.snapshot.paramMap.get('price');
    this.price = this.sendPrice;
    this.sendDate_start = _route.snapshot.paramMap.get('date_start');
    console.log("date de début : " + this.sendDate_start)
    this.sendDate_start = this.sendDate_start.replace(/\//gi, "-");
    console.log("date de début : " + this.sendDate_start)
    this.date_start = this.sendDate_start;
    this.sendDate_end = _route.snapshot.paramMap.get('date_end');
    console.log("date de fin : " + this.sendDate_end)
    this.sendDate_end = this.sendDate_end.replace(/\//gi, "-");
    console.log("date de fin : " + this.sendDate_end)
    this.date_end = this.sendDate_end;
  }

  ngOnInit(): void {
  }

  update(form: NgForm) {
    console.log(form)
    if (this.price === this.sendPrice && this.date_start === this.sendDate_start && this.date_end === this.sendDate_end) {
      console.log("Aucun paramètre n'a été modifié.")
      this.error = "Aucun paramètre n'a été modifié. Cette action est inutile."
      return
    }

    this.error = "";
    this.isLoading = true;
    const sale = new UpdateSale(this.idSale, this.price, this.date_start, this.date_end);
    this._updateSale.UpdateSale(sale).subscribe(data => {
      console.log(data);
      this.isLoading = false;
      if (data["request"] == 1) {
        this.message = data["result"];
      }
    }, error => {
      console.log(error);
      this.isLoading = false;
      if (error["error"]["request"] == 0) {
        this.isLoading = false
        this.error = error["error"]["result"]
      }
    })
  }

  delete(form: NgForm) {
    this.isLoading = true;
    const sale = new DeleteSale(this.idSale);
    this._updateSale.DeleteSale(sale).subscribe(data => {
      console.log(data);
      this.isLoading = false;
      if (data["request"] == 1) {
        this.message = data["result"];
      }
    }, error => {
      console.log(error);
      this.isLoading = false;
      if (error["error"]["request"] == 0) {
        this.isLoading = false
        this.error = error["error"]["result"]
      }
    })
  }
}
