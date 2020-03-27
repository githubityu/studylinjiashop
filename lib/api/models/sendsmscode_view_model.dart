import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

SendSmsViewModel sendSmsViewModel = new SendSmsViewModel();

class SendSmsViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future getData(phone) async {
    final  data = await SendSmsCodeModel().data(phone);
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return Future.value(null);
  }
}
