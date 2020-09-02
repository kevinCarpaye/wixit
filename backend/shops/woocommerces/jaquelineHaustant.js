
const WooCommerceRestApi = require('@woocommerce/woocommerce-rest-api').default;

const jaquelinehaustant = new WooCommerceRestApi({
    url: 'https://www.jaquelinehaustant.fr',
    consumerKey: 'ck_071a19408508b0297011893fd5a56101cb24b07e',
    consumerSecret: 'cs_996c128f0975ea51e4f119d4fb91ded5065fb3cb',
    version: 'wc/v3',
    queryStringAuth: true
  });

  module.exports = jaquelinehaustant;