import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'cart_goods_query_modle.dart';
import 'category_modle.dart';

CartGoodsQueryViewModel cartGoodsQueryViewModel = new CartGoodsQueryViewModel();

class CartGoodsQueryViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<CartGoodsQueryEntity> getData() async {
    final data = await GoodsListModel2().data();
    if (data != null && data.isNotEmpty) {
      return CartGoodsQueryEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
