import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'login_modle.dart';
import 'order_detail_model.dart';

OrderDetailViewModel orderDetailViewModel = new OrderDetailViewModel();

class OrderDetailViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<OrderDetailEntry> getData(orderSn) async {
    final Map data = await OrderDetailModel2().data(orderSn);
    if (data != null && data.isNotEmpty) {
      return OrderDetailEntry.fromJson(data);
    }
    return Future.value(null);
  }
}
