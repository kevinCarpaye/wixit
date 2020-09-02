import { TestBed } from '@angular/core/testing';

import { AddArticleService } from './add-article.service';

describe('AddArticleService', () => {
  let service: AddArticleService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AddArticleService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
