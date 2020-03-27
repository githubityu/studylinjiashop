
import 'dart:convert';

import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

class FileModel2 extends ReqModel {

  Map<String, dynamic> params2;

  @override
  String encodeData() {
    return json.encode(params2);
  }

  @override
  String url() {
    return API.uploadBase64;
  }

  Future data(Map<String, dynamic> params2) {
    this.params2 = params2;
    return post();
  }
}


class FileEntity {
  FileModel  msgModel;
  FileEntity({this.msgModel});
  FileEntity.fromJson(Map<String, dynamic> json) {
    msgModel =FileModel.fromJson(json,"成功");
  }
}
class FileModel {
  String avatar;
  String nickName;
  String msg;

  FileModel({this.avatar, this.nickName,this.msg});
  FileModel.fromJson(Map<String, dynamic> json,String message) {
    avatar = json['avatar'];
    nickName = json['nickName'];
    msg=message;
  }

}