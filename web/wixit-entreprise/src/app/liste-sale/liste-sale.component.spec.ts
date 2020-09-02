import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ListeSaleComponent } from './liste-sale.component';

describe('ListeSaleComponent', () => {
  let component: ListeSaleComponent;
  let fixture: ComponentFixture<ListeSaleComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ListeSaleComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListeSaleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
