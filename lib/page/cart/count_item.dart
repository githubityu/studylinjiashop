import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studylinjiashop/api/models/cart_goods_query_modle.dart';
import 'package:studylinjiashop/api/models/void_modle.dart';
import 'package:studylinjiashop/api/models/void_view_model.dart';
import 'package:studylinjiashop/http/mvvms.dart';
import 'package:studylinjiashop/receiver/event_bus.dart';
import 'package:studylinjiashop/utils/app_size.dart';

class CartCount extends StatelessWidget {
  GoodsModel item;
  IMvvmView view;
  CancelToken cancelToken;
  CartCount(this.item, this.view, this.cancelToken);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.width(190.0),
      height: AppSize.width(65),
      margin: EdgeInsets.only(top: 5.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        loadReduce(context, item.orderId, item.countNum - 1);
      },
      child: Container(
        width: AppSize.width(55),
        height: AppSize.width(55),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.countNum > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: item.countNum > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  void loadReduce(
      BuildContext context, String orderId, int count) async {
    VoidViewModel.get(view, cancelToken).getData(
        type: VoidModel.CART_UPDATE, params2: {"id": orderId, "count": count}).then((onValue) {
      item.countNum--;
      eventBus.fire(new GoodsNumInEvent("sub"));
    });
  }

  //添加按钮
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        addCart(context, item.id, 1, item.idSku);
      },
      child: Container(
        width: AppSize.width(55),
        height: AppSize.width(55),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  void addCart(BuildContext context, String idGoods, int count, String idSku) async {
    VoidViewModel.get(view, cancelToken).getData(type: VoidModel.CART_ADD, params2: {
      "idGoods": idGoods,
      "count": count,
      "idSku": idSku
    }).then((onValue) {
      item.countNum++;
      eventBus.fire(GoodsNumInEvent("add"));
    });
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: AppSize.width(70),
      height: AppSize.width(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.countNum}'),
    );
  }
}
