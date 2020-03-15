import 'package:flutter/material.dart';
import 'package:studylinjiashop/api/models/cart_goods_query_modle.dart';
import 'package:studylinjiashop/api/models/order_model.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';

import 'package:studylinjiashop/routes/shop_router.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/view/custom_view.dart';
import 'package:studylinjiashop/view/theme_ui.dart';

class OrderCard extends StatelessWidget {
  final List<OrderModel> orderModleDataList;
  String imgUrl = "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  OrderCard({Key key, this.orderModleDataList}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color:Colors.white,
        margin: EdgeInsets.only(top: 5.0),
    padding:EdgeInsets.all(3.0),
    child:  _buildWidget(context)
    );
  }
  Widget _buildWidget(BuildContext context) {
    List<Widget> mGoodsCard = [];
    Widget content;
    for (int i = 0; i < orderModleDataList.length; i++) {
      mGoodsCard.add(Container(
        width: AppSize.width(1080),
        child:Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                onItemClick(context,i);
              },
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child:Container(
                        padding: EdgeInsets.only(left: 10),
                        child:  Text('订单编号:', style: ThemeTextStyle.orderFormStatusStyle,)
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child:
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          orderModleDataList[i].statusName,
                          textAlign: TextAlign.right,
                          style: ThemeTextStyle.detailStylePrice,)
                    )
                    ,flex: 1,
                  )
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    orderModleDataList[i].orderSn,
                    textAlign: TextAlign.left,
                    style: ThemeTextStyle.cardTitleStyle,
                  ) ,
                )

              ],

            ),
            _buildOrderSub(orderModleDataList[i].goods),
            ThemeView.divider(),
            SizedBox(
              height: AppSize.height(120.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.white,
                      textColor: Colors.grey,
                      child: Text('取消订单', style: ThemeTextStyle.orderFormStatusStyle),
                      onPressed: () {

                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child:   MaterialButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('立即付款',style: ThemeTextStyle.orderStylePrice),
                        onPressed: () {
                          String totalPriceStr = (orderModleDataList[i].totalPrice / 100).toStringAsFixed(2);
                          Map<String, String> p={"orderSn":orderModleDataList[i].orderSn,"totalPrice":totalPriceStr};
                          NavigatorUtils.push(context,ShopRouter.pay_page,params: p);
                        },
                      ),
                    )
                  ,
                  ]),
            )

          ],
        ) ,
      ));

    }
    content = Column(
      children: mGoodsCard,
    );
    return content;
  }

  Widget _buildOrderSub(List<GoodsListModel> goodsModleDataList){
    List<Widget> mGoodsSubCard = [];
    Widget contentSub;
    for (int i = 0; i < goodsModleDataList.length; i++) {
      double priceDouble = goodsModleDataList[i].goodsModel.price/100;
      mGoodsSubCard.add(ThemeCard(
        title: goodsModleDataList[i].goodsModel.name,
        price:"¥"+priceDouble.toStringAsFixed(2) ,
        imgUrl:imgUrl+goodsModleDataList[i].goodsModel.pic,
        descript: goodsModleDataList[i].goodsModel.descript,
        number: "x"+goodsModleDataList[i].count.toString(),
      ));
    }
    contentSub = Column(
      children: mGoodsSubCard,
    );
    return contentSub;
  }
  void onItemClick(BuildContext context,int i){
    String orderSn = orderModleDataList[i].orderSn;
    Map<String, String> p={"orderSn":orderSn};
    NavigatorUtils.push(context,ShopRouter.ORDER_DETAILS,params: p);
  }


}