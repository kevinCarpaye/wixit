import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListeArticlesComponent } from './liste-articles/liste-articles.component';
import { AddArticleComponent } from './add-article/add-article.component';
import { HomeComponent } from './home/home.component';
import { LoginComponent } from './login/login.component';
import { UpdateArticleComponent } from './update-article/update-article.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { ListeSaleComponent } from './liste-sale/liste-sale.component';
import { UpdateSaleComponent } from './update-sale/update-sale.component';
import { AddSaleComponent } from './add-sale/add-sale.component';
import { AuthGuard } from './service/auth.guard';


const routes: Routes = [
  { path : 'home', component: HomeComponent},
  { path : 'connexion', component: LoginComponent},
  { 
    path : 'dashboard', 
    component: DashboardComponent, 
    canActivate: [AuthGuard]
  },
  { path : 'dashboard/:id/:name/:image', component: DashboardComponent},
  { path : 'listArticle', component: ListeArticlesComponent},
  { path : 'listSale', component: ListeSaleComponent},
  { path : 'addArticle', component: AddArticleComponent},
  { path : 'addSale', component: AddSaleComponent},
  { path : 'updateArticle', component: UpdateArticleComponent},
  { path : 'updateSale', component : UpdateSaleComponent},
  
  //{ path : 'updateArticle/:image/:name/:barcode/:description/:type/:idPrice/:price_base/:stock', component: UpdateArticleComponent},
  { path: '', redirectTo: 'home', pathMatch: 'full'}
  //{ path: '**', component: }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
