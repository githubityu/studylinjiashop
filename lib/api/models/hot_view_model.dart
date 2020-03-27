import 'package:studylinjiashop/http/view_model.dart';

import 'hot_modle.dart';

HotViewModel hotViewModel = new HotViewModel();

class HotViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<HotEntity> getData({type = 0, key = ""}) async {
    final data = await HotModel().data(type, key);
    if (data != null && data.isNotEmpty) {
      return HotEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
