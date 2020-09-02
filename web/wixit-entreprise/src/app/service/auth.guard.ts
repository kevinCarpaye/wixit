import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { map, tap, take } from 'rxjs/operators';
import { Injectable } from '@angular/core';

import { ShopLoginService } from './shop-login.service';


@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
    constructor(private authService: ShopLoginService, private router: Router) { }
    canActivate(
        route: ActivatedRouteSnapshot,
        router: RouterStateSnapshot
    ): boolean | Promise<boolean> | Observable<boolean | UrlTree> {
        return this.authService.shop.pipe(
            take(1),
            map(shop => {
            const isAuth = !!shop
            if (isAuth) {
                return true;
            }
            else {
                return this.router.createUrlTree(['connexion']);
            }
        }),
            // tap(isAuth => {
            //     if (!isAuth) {
            //         this.router.navigate(['login']);
            //     }
            // })
        );
    }
}
