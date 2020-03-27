import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'login_modle.dart';
import 'order_detail_model.dart';
import 'topic_details_model.dart';

TopicDetailViewModel topicDetailViewModel = new TopicDetailViewModel();

class TopicDetailViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<TopicDetailsEntity> getData(id) async {
    final Map data = await TopicDetailModel().data(id);
    if (data != null && data.isNotEmpty) {
      return TopicDetailsEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
