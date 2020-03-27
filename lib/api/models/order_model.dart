import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/config/const.dart';
import 'package:studylinjiashop/http/req_model.dart';

import 'cart_goods_query_modle.dart';

class OrderModel2 extends ReqModel {
  int status;
  int page;

  @override
  String url() => API.getOrders;

  @override
  Map<String, dynamic> params() {
    return {"status": status, "page": page, "limit": limitSize};
  }

  Future data(status, page) {
    this.status = status;
    this.page = page;
    return get();
  }
}

class OrderEntity {
  List<OrderModel> orderModel;

  OrderEntity({this.orderModel});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    orderModel = new List<OrderModel>();
    (json['records'] as List).forEach((v) {
      orderModel.add(new OrderModel.fromJson(v));
    });
  }
}

class OrderModel {
  String orderSn;
  int realPrice;
  int totalPrice;
  String statusName;
  int status;
  List<GoodsListModel> goods;

  OrderModel(
      {this.orderSn,
      this.realPrice,
      this.totalPrice,
      this.statusName,
      this.status,
      this.goods});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderSn = json['orderSn'];
    realPrice = json['realPrice'];
    totalPrice = json['totalPrice'];
    statusName = json['statusName'];
    status = json['status'];
    goods = List<GoodsListModel>();
    (json['items'] as List).forEach((v) {
      goods.add(new GoodsListModel.fromJson(v));
    });
  }
}
