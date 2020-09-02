import { TestBed } from '@angular/core/testing';

import { AddSaleService } from './add-sale.service';

describe('AddSaleService', () => {
  let service: AddSaleService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AddSaleService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
