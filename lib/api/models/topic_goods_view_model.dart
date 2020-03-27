import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'category_modle.dart';
import 'goods_modle.dart';
import 'hot_modle.dart';
import 'topic_goods_query_modle.dart';

TopicGoodsViewModel topicGoodsViewModel = new TopicGoodsViewModel();

class TopicGoodsViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<TopicGoodsQueryEntity> getData() async {
    final data = await TopicGoodsListModel2().data();
    if (data != null && data.isNotEmpty) {
      return TopicGoodsQueryEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
