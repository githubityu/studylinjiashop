import 'package:dio/dio.dart';
import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/mvvms.dart';
import 'package:studylinjiashop/http/req_model.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';

class LoginBeanModel extends ReqModel {
  String phone;
  String codeOrPwd;

  /// 0 验证码 1 密码
  int type;

  LoginBeanModel(CancelToken cancelToken,IMvvmView view) {
    this.view = view;
    this.cancelToken = cancelToken;
  }

  @override
  String url() => type == 0 ? API.loginOrReg : API.loginByPass;

  @override
  Map<String, dynamic> params() {
    return {"mobile": phone, type == 0 ? "smsCode" : "password": codeOrPwd};
  }

  Future data(phone, codeOrPwd, type) {
    this.phone = phone;
    this.codeOrPwd = codeOrPwd;
    this.type = type;
    return post();
  }

//  @override
//  handError(int statusCode, {msg}) {
//    DialogUtil.buildToast("重写了报错方法");
//  }
}

class LoginBean {
  String initPassword;
  User user;
  String token;

  LoginBean({this.initPassword, this.user, this.token});

  LoginBean.fromJson(Map<String, dynamic> json) {
    initPassword = json['initPassword'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['initPassword'] = this.initPassword;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String avatar;
  String createTime;
  String gender;
  String id;
  String lastLoginTime;
  String mobile;
  String nickName;
  String password;
  String salt;

  User(
      {this.avatar,
      this.createTime,
      this.gender,
      this.id,
      this.lastLoginTime,
      this.mobile,
      this.nickName,
      this.password,
      this.salt});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    createTime = json['createTime'];
    gender = json['gender'];
    id = json['id'];
    lastLoginTime = json['lastLoginTime'];
    mobile = json['mobile'];
    nickName = json['nickName'];
    password = json['password'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['createTime'] = this.createTime;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['lastLoginTime'] = this.lastLoginTime;
    data['mobile'] = this.mobile;
    data['nickName'] = this.nickName;
    data['password'] = this.password;
    data['salt'] = this.salt;
    return data;
  }
}
