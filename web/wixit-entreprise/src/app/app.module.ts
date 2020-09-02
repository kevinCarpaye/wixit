import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from "@angular/common/http";
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { HeaderComponent } from './header/header.component';
import { HomeComponent } from './home/home.component';
import { Header2Component } from './header2/header2.component';
import { ListeArticlesComponent } from './liste-articles/liste-articles.component';
import { AddArticleComponent } from './add-article/add-article.component';
import { UpdateArticleComponent } from './update-article/update-article.component';
import { LoadingSpinnerComponent } from './loading-spinner/loading-spinner.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { SearchrticlePipe } from './searchrticle.pipe';
import { ListeSaleComponent } from './liste-sale/liste-sale.component';
import { UpdateSaleComponent } from './update-sale/update-sale.component';
import { AddSaleComponent } from './add-sale/add-sale.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HeaderComponent,
    HomeComponent,
    Header2Component,
    ListeArticlesComponent,
    AddArticleComponent,
    UpdateArticleComponent,
    LoadingSpinnerComponent,
    DashboardComponent,
    SearchrticlePipe,
    ListeSaleComponent,
    UpdateSaleComponent,
    AddSaleComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
