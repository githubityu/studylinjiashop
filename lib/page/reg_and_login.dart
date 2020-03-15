import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studylinjiashop/api/models/login_view_model.dart';
import 'package:studylinjiashop/base/base_page_state.dart';
import 'package:studylinjiashop/config/user_info_data.dart';
import 'package:studylinjiashop/receiver/event_bus.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';
import 'package:studylinjiashop/utils/image_utils.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/view/flutter_iconfont.dart';
import 'package:studylinjiashop/view/theme_ui.dart';
import 'package:studylinjiashop/widget/load_image.dart';

import 'reset_pwd_page.dart';

class RegPageAndLoginPage extends StatefulWidget {
  @override
  _RegAndLoginState createState() => _RegAndLoginState();
}

class _RegAndLoginState extends BasePageState<RegPageAndLoginPage> {
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();

  ///用户账号
  String _userName = "";

  ///用户密码
  String _pwd = "";
  String _smsCode = "";
  bool isSendSms = false;

  bool _isObscure = true;
  IconData _icon = IconFonts.eye_close;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(title: "登录注册"),
        ),
        body: Container(
          color: ThemeColor.appBg,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: AppSize.height(450),
                    child: LoadAssetImage(
                      'banner',
                      format: "jpg",
                      fit: BoxFit.fill,
                    )),
                Container(
                  padding: EdgeInsets.only(
                      right: AppSize.width(60), left: AppSize.width(60)),
                  decoration: ThemeDecoration.card,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNum,
                        maxLines: 1,
                        maxLength: 11,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_iphone),
                            hintText: "请输入手机号",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30))),
                        onChanged: (inputStr) {
                          print("username   " + inputStr);
                          _userName = inputStr;
                        },
                      ),
                      _buildSmsInputOrPasswordInput(),
                      InkWell(
                        onTap: () {
                          isSendSms
                              ? loadLoginOrReg(_userName, _smsCode)
                              : loadLoginByPass(_userName, _pwd);
                        },
                        child: Container(
                          width: double.infinity,
                          height: AppSize.height(100),
                          padding: EdgeInsets.only(
                              right: AppSize.width(60),
                              left: AppSize.width(60)),
                          child: Center(
                              child: Text(
                            '登录',
                            style: TextStyle(
                                fontSize: AppSize.sp(45), color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ThemeColor.loignColor,
                                ThemeColor.loignColor
                              ]),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1.0, 5.0),
                                  color: ThemeColor.loignColor,
                                  blurRadius: 5.0,
                                )
                              ]),
                        ),
                      ),
                      _buildSmsOrPass(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildSmsInputOrPasswordInput() {
    return isSendSms
        ? Padding(
            padding: EdgeInsets.only(
                top: AppSize.height(30), bottom: AppSize.height(60)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: "请输入验证码",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    onChanged: (inputStr) {
                      print("smscode   " + inputStr);
                      _smsCode = inputStr;
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: AppSize.height(30),
                      left: AppSize.width(600),
                      right: AppSize.width(30),
                    ),
                    width: AppSize.width(486.0),
                    child: ResetCodePage(
                        onTapCallback: () {}, phoneNum: _userName))
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
                top: AppSize.height(30), bottom: AppSize.height(60)),
            child: TextField(
              controller: _password,
              maxLines: 1,
              maxLength: 32,
              obscureText: _isObscure,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: "请输入登录密码",
                contentPadding:
                    EdgeInsets.symmetric(vertical: AppSize.height(30)),
                suffixIcon: IconButton(
                    icon: Icon(
                      _icon,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                        _icon = _isObscure
                            ? IconFonts.eye_close
                            : Icons.remove_red_eye;
                      });
                    }),
              ),
              onChanged: (inputStr) {
                print("password   " + inputStr);
                _pwd = inputStr;
              },
            ),
          );
  }

  /// 返回用户或短信登录

  Widget _buildSmsOrPass() {
    String buttonName = isSendSms ? '用户名密码登录' : '手机短信登录/注册';
    return InkWell(
      onTap: () {
        setState(() {
          isSendSms = !isSendSms;
        });
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: AppSize.height(30)),
        padding: EdgeInsets.symmetric(vertical: AppSize.height(20)),
        child: Center(
            child: Text(
          buttonName,
          style: TextStyle(fontSize: AppSize.sp(45), color: Colors.white),
        )),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ThemeColor.appBarTopBg, ThemeColor.appBarBottomBg]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(1.0, 5.0),
                color: ThemeColor.appBarBottomBg,
                blurRadius: 5.0,
              )
            ]),
      ),
    );
  }

  void loadLoginByPass(String userName, String password) async {
    loginViewModel.getData(userName, password, 1).then((data) {
      if (data != null) {
        UserInfoData.instance.setToken(data.token);
        UserInfoData.instance.setNickName(data.user.nickName);
        UserInfoData.instance.setAvatar(data.user.avatar);
        loginSuccess();
      } else {
        DialogUtil.buildToast("登录失败");
      }
    }).catchError((onError) {
      DialogUtil.buildToast("抓住了错误信息");
    });
  }

  void loadLoginOrReg(String userName, String codeOrPwd) async {
    loginViewModel.getData(userName, codeOrPwd, 0).then((data) {
      if (data != null) {
        UserInfoData.instance.setToken(data.token);
        UserInfoData.instance.setNickName(data.user.nickName);
        UserInfoData.instance.setAvatar(data.user.avatar);
        loginSuccess();
      } else {
        DialogUtil.buildToast("登录失败");
      }
    }).catchError((onError) {
      DialogUtil.buildToast("抓住了错误信息");
    });
  }

  loginSuccess() {
    DialogUtil.buildToast("登录成功~");
    NavigatorUtils.pop(context);
    eventBus.fire(UserLoggedInEvent("sucuss"));
  }

  @override
  injectViewModelView() {
    loginViewModel.view = this;
    loginViewModel.cancelToken = getCancelToken();
  }
}
