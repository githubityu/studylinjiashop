import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

import 'goods_modle.dart';

class HotModel extends ReqModel {
  int type;
  String key;

  @override
  String url() {
    String url = "";
    switch (type) {
      case 2:
        url = API.search;
        break;
      case 1:
        url = API.goodsSearchNew;
        break;
      default:
        url = API.goodsSearchHot;
        break;
    }
    return url;
  }

  @override
  Map<String, dynamic> params() {
    if (key.isNotEmpty) {
      return {"key": key};
    } else {
      return {};
    }
  }

  Future data(type, key) {
    this.type = type;
    this.key = key;
    return get();
  }
}

class HotEntity {
  List<GoodsModel> goods;

  HotEntity({this.goods});

  HotEntity.fromJson(List<dynamic> json) {
    goods = new List<GoodsModel>();
    List<Map> dataList = json.cast();
    dataList.forEach((v) {
      goods.add(new GoodsModel.fromJson(v));
//				print(goods.length);
    });
  }
}
