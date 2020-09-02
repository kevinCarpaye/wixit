import { Component, OnInit } from '@angular/core';
import { LoginComponent } from '../login/login.component';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  private userSub: Subscription;
  isAuthenticated = false;

  constructor() {
    
   }

  ngOnInit(): void {
  }

}
