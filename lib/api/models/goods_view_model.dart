import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'category_modle.dart';
import 'goods_modle.dart';

GoodsViewModel goodsViewModel = new GoodsViewModel();

class GoodsViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<GoodsEntity> getData(idCategory) async {
    final data = await GoodsModel2().data(idCategory);
    if (data != null && data.isNotEmpty) {
      return GoodsEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
