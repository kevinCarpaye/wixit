export class AddArticle {
    constructor(
        public idShop: number,
        public name: string,
        public barcode: string,
        public description: string,
        public type: string,
        public price_base: number,
        public stock: number) {

    }
}