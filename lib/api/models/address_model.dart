import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

class AddressModel2 extends ReqModel {
  String id;

  @override
  String url() => "${API.addressByUser}$id";

  Future data(id) {
    this.id = id;
    return get();
  }
}

class AddressEditEntity {
  AddressModel addressModel;

  AddressEditEntity({this.addressModel});

  AddressEditEntity.fromJson(Map<String, dynamic> json) {
    addressModel = AddressModel.fromJson(json);
  }
}

class AddressModel {
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
  bool isDefault;
  String name;
  String province;
  String tel;
  String id;
  String idUser;
  bool isDelete;

  AddressModel(
      {this.addressDetail,
      this.areaCode,
      this.city,
      this.district,
      this.isDefault,
      this.name,
      this.province,
      this.tel,
      this.id,
      this.idUser,
      this.isDelete});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressDetail = json['addressDetail'].toString();
    areaCode = json['areaCode'].toString();
    city = json['city'].toString();
    district = json['district'].toString();
    isDefault = json['isDefault'];
    name = json['name'].toString();
    province = json['province'].toString();
    tel = json['tel'].toString();
    id = json['id'].toString();
    idUser = json['idUser'].toString();
    isDelete = json['isDelete'];
  }
}
