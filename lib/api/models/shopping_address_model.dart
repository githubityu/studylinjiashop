import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

class ShoppingAddressModel2 extends ReqModel {
  @override
  String url() => API.queryAddressByUser;
}

class ShoppingAddressEntry {
  List<ShoppingAddressModel> shippingAddressModels;

  ShoppingAddressEntry({this.shippingAddressModels});

  ShoppingAddressEntry.fromJson(List<dynamic> json) {
    shippingAddressModels = new List<ShoppingAddressModel>();
    (json).forEach((v) {
      shippingAddressModels.add(new ShoppingAddressModel.fromJson(v));
    });
  }
}

class ShoppingAddressModel {
//  "addressDetail":"人民路12号",
//  "areaCode":"110101",
//  "city":"北京市",
//  "createTime":"",
//  "district":"东城区",
//  "id":"1",
//  "idUser":"1",
//  "isDefault":true,
//  "isDelete":false,
//  "modifyTime":"",
//  "name":"路飞",
//  "postCode":"",
//  "province":"北京市",
//  "tel":"15011113333"
  String addressDetail;
  String areaCode;
  String city;
  String district;
  String name;
  String province;
  String tel;
  String id;
  bool isDefault;

  ShoppingAddressModel(
      {this.addressDetail,
      this.areaCode,
      this.city,
      this.district,
      this.name,
      this.province,
      this.tel,
      this.id,
      this.isDefault});

  ShoppingAddressModel.fromJson(Map<String, dynamic> json) {
    addressDetail = json['addressDetail'];
    areaCode = json['areaCode'];
    district = json['district'];
    name = json['name'];
    province = json['province'];
    tel = json['tel'];
    id = json['id'];
    city = json['city'];
    isDefault = json['isDefault'];
  }
}
