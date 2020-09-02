import { Component, OnInit } from '@angular/core';
import { Types } from '../model/type';
import { TypesService } from '../service/types.service';
import { Form, NgForm } from '@angular/forms';
import { HttpClient, HttpEventType, HttpHeaders } from '@angular/common/http';
import { AddArticleService } from '../service/add-article.service';
import { AddArticle } from '../model/add-article';

@Component({
  selector: 'app-add-article',
  templateUrl: './add-article.component.html',
  styleUrls: ['./add-article.component.scss']
})

export class AddArticleComponent implements OnInit {

  BASE_URL = "http://localhost:4000/api/uploadArticleImageByShop"
  error = null;
  message = null;
  ListTypes: Array<String> = new Array<String>()
  fileData: File = null;
  previewUrl: any = null;
  fileUploadProgress: string = null;
  uploadedFilePath: string = null;
  isSendable = false;
  isLoading = false;

  constructor(private http: HttpClient, private _articles: TypesService, private _addArticle: AddArticleService) {
    this.ListTypes[0] = 'Autre';
    this._articles.GetArticles().subscribe((data) => {
      console.log(data);
      data["response"].forEach(element => {
        console.log(element.type)
        this.ListTypes.push(element)
      });
    })
  }

  ngOnInit(): void {
  }

  fileProgress(fileInput: any) {
    this.fileData = <File>fileInput.target.files[0];
    console.log("true")
    this.isSendable = true;
    this.preview();
  }

  preview() {
    // Show preview 
    var mimeType = this.fileData.type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }


  }


  onSubmit(form: NgForm) {
    this.error = "";
    if (this.isSendable == false) {
      this.error = "L'image de l'article est obligatoire"
      return;
    }
    this.isLoading = true
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

    const parameters = LocalStorageManager.getValue("parameters")
    const idShop = parameters.idShop

    let name = null;
    if (form.value.name != "") {
      name = form.value.name;
    }

    const barcode = form.value.barcode;

    const desciption = form.value.desciption;

    let type = null;
    if (form.value.type != "") {
      type = form.value.type;
    }

    let price_base = null;
    if (form.value.price_base != "") {
      price_base = form.value.price_base;
    }

    const  stock = form.value.stock
    // console.log(idShop);
    // console.log(name);
    // console.log(barcode);
    // console.log(desciption);
    // console.log(type);
    const article = new AddArticle(idShop, name, barcode, desciption, type, price_base, stock)
    console.log(article);

    this._addArticle.AddArticle(article).subscribe(data => {
      console.log(data)
      if (data["request"] == 1) {
        this.error = null;
        const formData = new FormData();
        formData.append('file', this.fileData);
        //console.log("Le nom est :   " + parameters.name)
        this.http.post(this.BASE_URL, formData)
          .subscribe(res => {
            this.isLoading = false
            if(res["request"] == 1) {
              this.message = res["result"];
            }
            console.log(res);

            //this.uploadedFilePath = res.data.filePath;
            //alert('SUCCESS !!');
          },
          error => {
            console.log(error["error"]["request"]);
            if (error["error"]["request"] == 0) {
              this.isLoading = false
              this.error = error["error"]["result"]
            }
          })
      }
    },
      error => {
        console.log(error["error"]["request"]);
        if (error["error"]["request"] == 0) {
          this.isLoading = false
          this.error = error["error"]["result"]
        }
      })
  }
}
