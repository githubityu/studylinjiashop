import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studylinjiashop/common/functions.dart';
import 'package:studylinjiashop/config/const.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';
import 'package:studylinjiashop/routes/shop_router.dart';

import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/view/flutter_iconfont.dart';
import 'package:studylinjiashop/view/my_icons.dart.dart';
import 'package:studylinjiashop/widget/load_image.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child: CommonTopBar(title: "我的"),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderType(context),
          _orderTitle(context),
          _actionList(context)
        ],
      ),
    );
  }

  //头像区域

  Widget _topHeader() {
    return Container(
      width: double.infinity,
      height: AppSize.height(450),
      child: LoadAssetImage(
        "banner",
        format: IMAGE_JPG,
      ),
    );
  }

  @override
  void initState() {
//    print("--*-- _IndexPageState");
  }

  //我的订单顶部
  Widget _orderTitle(BuildContext context) {
    return InkWell(
      onTap: () {
        orderIndex = 0;
        NavigatorUtils.push(context, ShopRouter.order_page);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: ListTile(
          leading: Icon(Icons.assignment),
          title: Text('全部订单'),
          trailing: Icon(IconFonts.arrow_right),
        ),
      ),
    );
  }

  Widget _orderType(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: AppSize.width(1080),
      height: AppSize.height(160),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              orderIndex = 0;
              NavigatorUtils.push(context, ShopRouter.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.daifukuan,
                    size: 30,
                  ),
                  Text('待付款'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              orderIndex = 1;
              NavigatorUtils.push(context, ShopRouter.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.daifahuo,
                    size: 30,
                  ),
                  Text('待发货'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              orderIndex = 2;
              NavigatorUtils.push(context, ShopRouter.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.yifahuo,
                    size: 30,
                  ),
                  Text('已发货'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              orderIndex = 3;
              NavigatorUtils.push(context, ShopRouter.order_page);
            },
            child: Container(
              width: AppSize.width(270),
              child: Column(
                children: <Widget>[
                  Icon(
                    MyIcons.yiwancheng,
                    size: 30,
                  ),
                  Text('已完成'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//
  Widget _myListTile(
      {String title, Icon con, OnGoMineCallback onGoMineCallback}) {
    return InkWell(
      onTap: onGoMineCallback,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: ListTile(
          leading: con,
          title: Text(title),
          trailing: Icon(IconFonts.arrow_right),
        ),
      ),
    );
  }

  Widget _actionList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        // ignore: missing_return
        children: <Widget>[
          // ignore: missing_return
          _myListTile(
              title: '收货地址',
              con: Icon(MyIcons.addressholder),
              onGoMineCallback: () {
                return  NavigatorUtils.push(context, ShopRouter.address_page);
              }),
          // ignore: missing_return
          _myListTile(
              title: '我的积分',
              con: Icon(MyIcons.jifenholder),
              onGoMineCallback: () {
                return  NavigatorUtils.push(context, ShopRouter.address_page);
              }),
          // ignore: missing_return
          _myListTile(
              title: '我的优惠券',
              con: Icon(MyIcons.youhuiquanholder),
              onGoMineCallback: () {
                return NavigatorUtils.push(context, ShopRouter.address_page);
              }),
          // ignore: missing_return
          _myListTile(
              title: '我的礼物',
              con: Icon(MyIcons.liwuholder),
              onGoMineCallback: () {
                return NavigatorUtils.push(context, ShopRouter.address_page);
              }),
          // ignore: missing_return
          _myListTile(
              title: '设置',
              con: Icon(CupertinoIcons.gear_big),
              onGoMineCallback: () {
               return  NavigatorUtils.push(context, ShopRouter.setting_page);
              }),
        ],
      ),
    );
  }
}
