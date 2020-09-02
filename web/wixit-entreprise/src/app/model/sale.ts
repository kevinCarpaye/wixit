export class Sales {
  request: number;
  result: string;
  response: Response[];
}

class Response {
  idSale: number
  image: string;
  name: string;
  type: string;
  price_base: number;
  price: number;
  date_start: string;
  date_end: string;
}