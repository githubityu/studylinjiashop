import 'package:flutter/material.dart';
import 'package:studylinjiashop/api/models/void_modle.dart';
import 'package:studylinjiashop/api/models/void_view_model.dart';
import 'package:studylinjiashop/base/base_page_state.dart';
import 'package:studylinjiashop/res/colors.dart';
import 'package:studylinjiashop/res/colours.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/view/theme_ui.dart';

class ModifyPwdPage extends StatefulWidget {
  @override
  _ModifyPwdPageState createState() => _ModifyPwdPageState();
}

class _ModifyPwdPageState extends BasePageState<ModifyPwdPage> {
  String _inputOldText = '';
  String _inputNewText = '';
  String _inputAginText = '';

  Widget _buildPwdOld() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '*',
                        style: ThemeTextStyle.cardPriceStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '旧密码',
                        style: TextStyle(
                            color: Colours.text_dark,
                            fontSize: 14,
                            decoration: TextDecoration.none),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入旧密码",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                        onChanged: (inputStr) {
                          _inputOldText = inputStr;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }

  Widget _buildPwdNew() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '*',
                        style: ThemeTextStyle.cardPriceStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '新密码',
                        style: TextStyle(
                            color: Colours.text_dark,
                            fontSize: 14,
                            decoration: TextDecoration.none),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入新密码",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                        onChanged: (inputStr) {
                          _inputNewText = inputStr;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }

  Widget _buildPwdAgin() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '*',
                        style: ThemeTextStyle.cardPriceStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '确认密码',
                        style: TextStyle(
                            color: Colours.text_dark,
                            fontSize: 14,
                            decoration: TextDecoration.none),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请确认密码",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                        onChanged: (inputStr) {
                          _inputAginText = inputStr;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ThemeView.divider(),
        ],
      ),
    );
  }

  Widget _btnSave() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Material(
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(new Radius.circular(25.0)),
            ),
            child: InkWell(
              borderRadius: new BorderRadius.circular(25.0),
              onTap: () {
                if (_inputOldText.isEmpty) {
                  DialogUtil.buildToast('请输入旧密码');
                  return;
                }
                if (_inputNewText.isEmpty) {
                  DialogUtil.buildToast('请输入新密码');
                  return;
                }
                if (_inputAginText.isEmpty) {
                  DialogUtil.buildToast('请确认密码');
                  return;
                }

                loadSave(_inputOldText, _inputNewText, _inputAginText);
              },
              child: Container(
                width: 300.0,
                height: 50.0,
                //设置child 居中
                alignment: Alignment(0, 0),
                child: Text(
                  "保   存",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loadSave(String old, String newPwd, String aginPwd) async {
    VoidViewModel.get(this, getCancelToken()).getData(type: VoidModel.UPDATE_PWD, params2: {
      "old": old,
      "newPwd": newPwd,
      "rePassword": aginPwd
    }).then((onValue) {
      Navigator.pop(context);
      DialogUtil.buildToast("修改成功");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    return Scaffold(
      appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
              title: "修改姓名")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildPwdOld(),
            _buildPwdNew(),
            _buildPwdAgin(),
            _btnSave()
          ],
        ),
      ),
    );
  }
}
