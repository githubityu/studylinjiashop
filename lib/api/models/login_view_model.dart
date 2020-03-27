import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'login_modle.dart';

LoginViewModel loginViewModel = new LoginViewModel();

class LoginViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<LoginBean> getData(phone, codeOrPwd, type) async {
    final Map data = await LoginBeanModel(cancelToken,view).data(phone, codeOrPwd, type);
    if (data != null && data.isNotEmpty) {
      return LoginBean.fromJson(data);
    }
    return Future.value(null);
  }
}
