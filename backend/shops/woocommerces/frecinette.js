const WooCommerceRestApi = require('@woocommerce/woocommerce-rest-api').default;

const frecinette = new WooCommerceRestApi({
    url: 'https://www.frecinette.fr/',
    consumerKey: 'ck_d62d153b77545766441489a169ac5320ee659482',
    consumerSecret: 'cs_aecbc296c479e893574a78f591f7497978ae1e03',
    version: 'wc/v3',
    queryStringAuth: true
  });

  module.exports = frecinette;