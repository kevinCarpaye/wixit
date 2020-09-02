import { TestBed } from '@angular/core/testing';

import { DeleteArticleService } from './delete-article.service';

describe('DeleteArticleService', () => {
  let service: DeleteArticleService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DeleteArticleService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
