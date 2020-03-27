import 'package:studylinjiashop/api/models/sendsmscode_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

import 'category_modle.dart';

CategoryViewModel categoryViewModel = new CategoryViewModel();

class CategoryViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<CategoryEntity> getData() async {
    final data = await CategoryModel2().data();
    if (data != null && data.isNotEmpty) {
      return CategoryEntity.fromJson(data);
    }
    return Future.value(null);
  }
}
