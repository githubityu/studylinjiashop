import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/mvvms.dart';
import 'package:studylinjiashop/http/req_model.dart';

class VoidModel extends ReqModel {
  static const CART_UPDATE = 1;
  static const CART_ADD = 2;
  static const CART_DELETE_ALL = 0;
  static const GOODS_FAVORITE_LIKE = 3;
  static const GOODS_FAVORITE_ADD = 4;
  static const ADDRESS_SAVE_ADD = 5;
  static const UPDATE_GENDER = 6;
  static const UPDATE_PWD = 7;
  static const UPDATE_NICKNAME = 8;



  int type;
  Map<String, dynamic> params2;


  VoidModel(CancelToken cancelToken,IMvvmView view) {
    this.view = view;
    this.cancelToken = cancelToken;
  }


  get isEncode {
    return type == CART_ADD ||
        type == ADDRESS_SAVE_ADD;
  }

  @override
  Map<String, dynamic> params() {
    return isEncode ? null : params2;
  }

  @override
  String encodeData() {
    return isEncode ? json.encode(params2) : null;
  }

  @override
  String url() {
    String url = "";
    switch (type) {
      case CART_UPDATE:
        url = "${API.userCartUpdate}${params2["id"]}/${params2["count"]}";
        break;
      case CART_ADD:
        url = API.userCartAdd;
        break;
      case GOODS_FAVORITE_LIKE:
        url = "${API.favoriteLike}${params2["id"]}";
        break;
      case GOODS_FAVORITE_ADD:
        url = "${API.favoriteAdd}${params2["id"]}";
        break;
      case ADDRESS_SAVE_ADD:
        url = API.saveAddressByUser;
        break;
      case UPDATE_GENDER:
        url = "${API.updateGender}${params2["gender"]}";
        break;
      case UPDATE_NICKNAME:
        url = "${API.updateUserName}${params2["name"]}";
        break;
      case UPDATE_PWD:
        url = "${API.updatePassword}${params2["oldPwd"]}/${params2["pwd"]}/${params2["rePassword"]}";
        break;
      default:
        url = API.userCartDeleteAll;
        break;
    }
    return url;
  }

  Future data(type, Map<String, dynamic> params2) {
    this.type = type;
    this.params2 = params2;
    switch (type) {
      case CART_UPDATE:
      case CART_ADD:
      case GOODS_FAVORITE_ADD:
      case CART_DELETE_ALL:
      case ADDRESS_SAVE_ADD:
      case UPDATE_GENDER:
      case UPDATE_NICKNAME:
      case UPDATE_PWD:
        return post();
        break;
    }
    return get();
  }
}
