import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'address_model.dart';

AddressViewModel addressViewModel = new AddressViewModel();

class AddressViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<AddressEditEntity> getData(id) async {
    final data = await AddressModel2().data(id);
    if (data != null && data.isNotEmpty) {
      return AddressEditEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
