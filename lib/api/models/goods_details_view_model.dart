import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'goods_details_model.dart';
import 'login_modle.dart';
import 'order_detail_model.dart';

GoodsDetailViewModel goodsDetailViewModel = new GoodsDetailViewModel();

class GoodsDetailViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<DetailsEntity> getData(id) async {
    final Map data = await GoodsModelAndSkuModel().data(id);
    if (data != null && data.isNotEmpty) {
      return DetailsEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
