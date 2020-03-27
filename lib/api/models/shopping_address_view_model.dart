import 'package:studylinjiashop/api/models/shopping_address_model.dart';
import 'package:studylinjiashop/http/view_model.dart';

ShoppingAddressViewModel shoppingAddressViewModel = new ShoppingAddressViewModel();

class ShoppingAddressViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<ShoppingAddressEntry> getData() async {
    final data = await ShoppingAddressModel2().get();
    if (data != null) {
      return ShoppingAddressEntry.fromJson(data);
    }
    return Future.value(null);
  }
}
