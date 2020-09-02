import { TestBed } from '@angular/core/testing';

import { UpdateSaleService } from './update-sale.service';

describe('UpdateSaleService', () => {
  let service: UpdateSaleService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(UpdateSaleService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
