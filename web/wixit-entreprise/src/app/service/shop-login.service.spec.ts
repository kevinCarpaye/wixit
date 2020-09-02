import { TestBed } from '@angular/core/testing';

import { ShopLoginService } from './shop-login.service';

describe('ShopLoginService', () => {
  let service: ShopLoginService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ShopLoginService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
