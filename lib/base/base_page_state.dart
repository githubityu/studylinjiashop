import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studylinjiashop/http/mvvms.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';
import 'package:studylinjiashop/view/custom_view.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T>
    implements IMvvmView {
  CancelToken _cancelToken;

  BasePageState() {
    _cancelToken = CancelToken();
    injectViewModelView();
  }

  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  bool _isShowDialog = false;

  @override
  void showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async {
                  // 拦截到返回键，证明dialog被手动关闭
                  _isShowDialog = false;
                  return Future.value(true);
                },
                child: const LoadingDialog(
                  text: "加载中…",
                ),
              );
            });
      } catch (e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showToast(String string) {
    DialogUtil.buildToast(string);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    if (_cancelToken != null && !_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  void didUpdateWidgets<W>(W oldWidget) {}

  CancelToken getCancelToken() {
    return _cancelToken;
  }

  //如果要用model与view交互就需要给viewmodle 设置view
  void injectViewModelView() {}
}
