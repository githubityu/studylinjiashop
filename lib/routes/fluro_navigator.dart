import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:studylinjiashop/config/user_info_data.dart';
import 'package:studylinjiashop/routes/shop_router.dart';

import 'application.dart';
import 'routers.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {
  static initRouter() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  static push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Map<String, dynamic> params}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(
        context, navigateToReplace(path, params: params),
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false,
      bool clearStack = false,
      Map<String, dynamic> params}) {
    FocusScope.of(context).unfocus();
    Application.router
        .navigateTo(context, navigateToReplace(path, params: params),
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.maybePop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  static void pop(BuildContext context, {isPop = true}) {
    FocusScope.of(context).unfocus();
    if (isPop == true) {
      Navigator.pop(context);
    } else {
      Navigator.maybePop(context);
    }
  }

  /// 跳到WebView页
  static goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, Routes.webViewPage, params: {"title": title, "url": url});
  }

  static goRootPage(BuildContext context) {
    //fluro 不支持传中文,需转换
    push(context, ShopRouter.root_page, replace: true);
  }

  static bool isLogin(context) {
    if (!UserInfoData.instance.isLogin) {
      push(context, ShopRouter.login_page);
      return false;
    }
    return true;
  }

  static String navigateToReplace(String path, {Map<String, dynamic> params}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
//    print('我是navigateTo传递的参数：$query');
    return path = path + query;
  }
}
