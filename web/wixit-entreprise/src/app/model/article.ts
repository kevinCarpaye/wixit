export class Article {
    request: number;
    result: string;
    resp: Resp[];
  }
  
export class Resp {
    name: string;
    barcode: string;
    image: string;
    description: string;
    type: string;
    price_base: number;
    stock: number;
    createdAt: string;
    updatedAt: string;
  }