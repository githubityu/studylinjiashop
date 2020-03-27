import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'login_modle.dart';
import 'order_detail_model.dart';
import 'order_model.dart';

OrderViewModel orderViewModel = new OrderViewModel();

class OrderViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<OrderEntity> getData(status,page) async {
    final Map data = await OrderModel2().data(status,page);
    if (data != null && data.isNotEmpty) {
      return OrderEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
