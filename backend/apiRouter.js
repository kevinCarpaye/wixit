//Imports
const express = require('express');
const registerCtrl = require('./routes/User/RegisterCtrl');
const loginCtrl = require('./routes/User/LoginCtrl');
const userProfilCtrl = require('./routes/User/UserProfilCtrl');
const articleCtrl = require('./routes/Articles/ArticleCtrl');
const shopCtrl = require('./routes/Shop/ShopCtrl');

//Routeur
exports.router = (function() {
    var apiRouter = express.Router();

    //Routes
    //apiRouter.route('/upload').post(registerCtrl.upload);
    //apiRouter.route('/upload').get(registerCtrl.vUpload);
    //apiRouter.route('/registerWithProfilPicture').post(registerCtrl.createUserWithProfilPicture)
    apiRouter.route('/registerWithoutProfilPicture').post(registerCtrl.createUserWithoutProfilPicture);
    apiRouter.route('/login').get(loginCtrl.login);
    apiRouter.route('/getUserProfil').get(userProfilCtrl.getUserProfil);
    apiRouter.route('/updateUserProfil').post(userProfilCtrl.updateUserProfil);
    apiRouter.route('/updatePassword').post(userProfilCtrl.updatePassword);

    apiRouter.route('/searchArticleWithBarcode').get(articleCtrl.SearchArticleWithBarcode);
    apiRouter.route('/searchArticleWithName').get(articleCtrl.SearchArticleWithName);
    apiRouter.route('/searchArticleByName').get(articleCtrl.SearchArticleByName);
    apiRouter.route("/fetchType").get(articleCtrl.fetchType);
    apiRouter.route('/addArticle').post(articleCtrl.AddArticleWithBarCode);
    apiRouter.route('/uploadArticleImage').post(articleCtrl.UploadAddedPicture);
    apiRouter.route('/listShopSearchWithBarcode').post(articleCtrl.ListShopSearchWithBarcode);
    
    apiRouter.route('/newArticles').get(articleCtrl.newArticle);
    apiRouter.route('/allArticlesByShop').get(articleCtrl.allArticlesByShop);
    apiRouter.route('/addArticleByShop').post(articleCtrl.addArticleByShop);
    apiRouter.route('/addSaleByShop').post(articleCtrl.addSale);
    apiRouter.route('/updateArticleByShop').put(articleCtrl.updateArticleByShop);
    apiRouter.route('/uploadArticleImageByShop').post(articleCtrl.UploadPictureByShop);
    apiRouter.route('/deleteArticleByshop').put(articleCtrl.deleteArticleByShop);
    apiRouter.route('/currentSales').get(articleCtrl.currentSales);
    apiRouter.route('/oldSales').get(articleCtrl.oldSales);
    apiRouter.route('/updateSaleByShop').put(articleCtrl.updateSale);
    apiRouter.route('/deleteSaleByShop').put(articleCtrl.deleteSale);
    
    apiRouter.route('/shopLogin').get(shopCtrl.shopLogin);
    apiRouter.route('/dashboard').get(shopCtrl.dashboard);
    apiRouter.route('/shopList').get(shopCtrl.shopsList);
    apiRouter.route('/shopListFetch').get(shopCtrl.shopsListFetch);
    apiRouter.route('/analytics').post(shopCtrl.analytics);
    
    return apiRouter; 
})();