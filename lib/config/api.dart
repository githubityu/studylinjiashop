class API {
  // 请求的url
  //static const reqUrl = 'http://10.0.2.2:8086';

//static const reqUrl = 'http://47.94.169.13:8086';
 static const reqUrl = 'http://192.168.1.8:8086';

  //
  static const sendSmsCode = '/login/sendSmsCode';
  static const loginOrReg = '/login/loginOrReg';
  static const loginByPass = '/login/loginByPass';
  static const categoryList = '/category/list';
  static const topicList = '/topic/list';
  static const goodsSearchHot = '/goods/searchHot';
  static const goodsSearchNew = '/goods/searchNew';
  static const goodsQueryGoods = '/goods/queryGoods';
  static const search = '/goods/search';
  static const queryCartByUser = '/user/cart/queryByUser';
  static const userCartDeleteAll = '/user/cart/delete';
  static const userCartUpdate = '/user/cart/update/';
  static const userCartAdd = '/user/cart/add';
  static const userOrderDetail = '/user/order/';
  static const goodsDetail = '/goods/';
  static const favoriteLike = '/user/favorite/ifLike/';
  static const favoriteAdd = '/user/favorite/add/';
  static const topicDetail = '/topic/';
  static const getOrders = '/user/order/getOrders';
  static const queryAddressByUser = '/user/address/queryByUser';
  static const saveAddressByUser = '/user/address/save';
  static const addressByUser = '/user/address/';
  static const updateGender = '/user/updateGender/';
  static const uploadBase64 = '/file/upload/base64';
  static const updatePassword = '/user/updatePassword/';
  static const updateUserName = '/user/updateUserName/';
//static const loginOrReg = '/user/getInfo';

}
