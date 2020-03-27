import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'file_upload_model.dart';
import 'goods_details_model.dart';
import 'login_modle.dart';
import 'order_detail_model.dart';

FileUploadViewModel fileUploadViewModel = new FileUploadViewModel();

class FileUploadViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<FileEntity> getData(params) async {
    final Map data = await FileModel2().data(params);
    if (data != null) {
      return FileEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
