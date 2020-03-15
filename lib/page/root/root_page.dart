import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package_info/package_info.dart';
import 'package:studylinjiashop/common/common.dart';
import 'package:studylinjiashop/page/cart/cart_page.dart';
import 'package:studylinjiashop/page/home/home_shop_page.dart';
import 'package:studylinjiashop/page/member/member_page.dart';
import 'package:studylinjiashop/page/search/search_page.dart';
import 'package:studylinjiashop/page/web_page.dart';
import 'package:studylinjiashop/res/colors.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';
import 'package:studylinjiashop/utils/double_tap_back_exit_app.dart';
import 'package:studylinjiashop/widget/dialog/update_dialog.dart';
import 'package:studylinjiashop/widget/root_tabbar.dart';

import '../reg_and_login.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime lastPopTime;

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  /// 检查更新 [check update]
  checkVersion() async {
//    if (Platform.isIOS) return;
//
//    final packageInfo = await PackageInfo.fromPlatform();
//
//    VersionModel model = await versionViewModel.getData();
//
//    int currentVersion = int.parse(removeDot(packageInfo.version));
//
//    int netVersion = int.parse(removeDot(model.appVersion));
//
//    if (currentVersion >= netVersion) {
//      debugPrint('当前版本是最新版本');
//      return;
//    }
//
//    showDialog(
//      context: context,
//      builder: (ctx2) {
//        return UpdateDialog(
//          version: model.appVersion,
//          updateUrl: model.downloadUrl,
//          updateInfo: model.updateInfo,
//          isForce: model.force,
//        );
//      },
//    );
  }

  @override
  Widget build(BuildContext context) {
    List<TabBarModel> pages = <TabBarModel>[
      new TabBarModel(
        title: '小铺',
        icon: Icon(CupertinoIcons.home),
        selectIcon: Icon(CupertinoIcons.home, color: Colours.fixedColor),
        page: HomePage(),
      ),
      new TabBarModel(
        title: '发现',
        icon: Icon(CupertinoIcons.search),
        selectIcon: Icon(CupertinoIcons.search, color: Colours.fixedColor),
        page: SearchPage(),
      ),
      new TabBarModel(
        title: '购物车',
        icon: Icon(CupertinoIcons.shopping_cart),
        selectIcon: Icon(CupertinoIcons.shopping_cart, color: Colours.fixedColor),
        page: CartPage(),
      ),
      new TabBarModel(
        title: '我的',
        icon: Icon(CupertinoIcons.profile_circled),
        selectIcon: Icon(CupertinoIcons.profile_circled, color: Colours.fixedColor),
        page: MemberPage(),
      ),
    ];
    return DoubleTapBackExitApp(
      child: RootTabBar(pages: pages, currentIndex: 0),
    );
    return new RootTabBar(pages: pages, currentIndex: 0);
  }
}

class LoadImage extends StatelessWidget {
  final String img;
  final bool isSelect;

  LoadImage(this.img, [this.isSelect = false]);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 2.0),
      width: 30.0,
      height: 30.0,
      child: new Image.asset(
        img,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        color: isSelect ? Colours.fixedColor : Colours.mainTextColor,
      ),
    );
  }
}
