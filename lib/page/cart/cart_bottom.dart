import 'package:flutter/material.dart';
import 'package:studylinjiashop/api/models/cart_goods_query_modle.dart';
import 'package:studylinjiashop/receiver/event_bus.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';
import 'package:studylinjiashop/routes/shop_router.dart';
import 'package:studylinjiashop/utils/app_size.dart';

class CartBottom extends StatelessWidget {

  List<GoodsModel> list;
  bool isAllCheck;
  CartBottom(this.list,this.isAllCheck);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        height:AppSize.height(140.0) ,
        color: Colors.white,
        width:AppSize.width(1080),
        child: Row(
              children: <Widget>[
                selectAllBtn(),
                allPriceArea(),
                goButton(context)
              ],
            )

        );

  }

  //全选按钮
  Widget selectAllBtn(){
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              list.forEach((el){
                el.isCheck= val;
              });
              eventBus.fire(new GoodsNumInEvent("All"));
            },
          ),
          Text('全选')
        ],
      ),
    );
  }
  double allPrice=0;
  // 合计区域
  Widget allPriceArea(){

    list.forEach((el){
      if(el.isCheck){
        allPrice=allPrice+ el.countNum*(el.price/100);
      }
    });
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: AppSize.width(220),
                height:AppSize.height(140) ,
                child: Text(
                    '合计:',
                    style:TextStyle(
                        fontSize: AppSize.sp(36)
                    )
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: AppSize.width(240),
                child: Text(
                    '￥${allPrice.toStringAsFixed(2)}',
                    style:TextStyle(
                      fontSize:AppSize.sp(36),
                      color: Colors.red,
                    )
                ),
              )
            ],
          ),
        ],
      ),
    );

  }

  //结算按钮
  Widget goButton(BuildContext context){
    int  allGoodsCount=0;
    int isAll=0;
    list.forEach((el){
      if(el.isCheck){
        isAll++;
        allGoodsCount=allGoodsCount+ el.countNum;

      }
    });
    if(isAll==list.length){
      eventBus.fire(new GoodsNumInEvent("All"));
    }
    return Container(
      width:AppSize.width(360),
      padding: EdgeInsets.only(left: 30),
      child:InkWell(
        onTap: (){
          Map<String, String> p={"orderSn":"","totalPrice":allPrice.toStringAsFixed(2)};
          NavigatorUtils.push(context,ShopRouter.pay_page,params: p);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ) ,
    );


  }


}