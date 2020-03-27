import 'package:studylinjiashop/common/common.dart';
import 'package:studylinjiashop/http/req_model.dart';

class SendSmsCodeModel extends ReqModel {
  String phone;

  @override
  String url() => API.sendSmsCode;

  @override
  Map<String, dynamic> params() {
    return {"mobile": phone};
  }

  Future data(phone) {
    this.phone = phone;
    return post();
  }
}
