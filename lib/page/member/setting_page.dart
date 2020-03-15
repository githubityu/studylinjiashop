import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studylinjiashop/api/models/file_upload_view_model.dart';
import 'package:studylinjiashop/api/models/void_modle.dart';
import 'package:studylinjiashop/api/models/void_view_model.dart';
import 'package:studylinjiashop/base/base_page_state.dart';
import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/config/user_info_data.dart';
import 'package:studylinjiashop/receiver/event_bus.dart';
import 'package:studylinjiashop/res/colors.dart';
import 'package:studylinjiashop/res/colours.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';

import 'package:studylinjiashop/routes/shop_router.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/utils/bottom_dialog.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';
import 'package:studylinjiashop/utils/utils.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/custom_view.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/view/flutter_iconfont.dart';
import 'package:studylinjiashop/view/my_icons.dart.dart';
import 'package:studylinjiashop/view/theme_ui.dart';
import 'package:studylinjiashop/widget/load_image.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage> {
  String imgUrl =
      "${API.reqUrl}/file/getImgStream?idFile=";
  File primaryFile;
  File compressedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _userSubscription.cancel();
  }

  ///修改姓名
  Widget _buildModifyName() {
    return InkWell(
        onTap: () {
          Map<String, String> p = {"name": getSafeData(UserInfoData.instance.nickName)};
          NavigatorUtils.push(context, ShopRouter.modify_name_page, params: p);
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(CupertinoIcons.profile_circled),
                        ),
                        Expanded(
                          child: Text(
                            '姓名',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Text(getSafeData(UserInfoData.instance.nickName),
                                style: TextStyle(
                                    color: Colours.text_gray,
                                    fontSize: 14,
                                    decoration: TextDecoration.none))),
                        Icon(IconFonts.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              ThemeView.divider(),
            ],
          ),
        ));
  }

  ///修改密码
  Widget _buildModifyPwd() {
    return InkWell(
        onTap: () {
           NavigatorUtils.push(context, ShopRouter.modify_pwd_page);
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.lock_outline),
                        ),
                        Expanded(
                          child: Text(
                            '修改密码',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
                        ),
                        Icon(IconFonts.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              ThemeView.divider(),
            ],
          ),
        ));
  }

  ///更换手机
  Widget _buildChangePhone() {
    return InkWell(
        onTap: () {
          DialogUtil.buildToast("敬请期待");
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.phone_forwarded),
                        ),
                        Expanded(
                          child: Text(
                            '更换手机',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
                        ),
                        Icon(IconFonts.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              ThemeView.divider(),
            ],
          ),
        ));
  }

  String getGender(String str) {
    if ("male" == str) {
      return "男";
    } else {
      return "女";
    }
  }

  Widget _buildSex() {
    return InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                var list = List();
                list.add('男');
                list.add('女');
                return CommonBottomSheet(
                  //uses the custom alert dialog
                  list: list,
                  onItemClickListener: (index) {
                    if (index == 0) {
                      Navigator.pop(context);
                      loadSexSave("male");
                    } else if (index == 2) {
                      Navigator.pop(context);
                      loadSexSave("female");
                    }
                  },
                );
              });
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(MyIcons.sexicon),
                        ),
                        Expanded(
                          child: Text(
                            '性别',
                            style: TextStyle(
                                color: Colours.text_dark,
                                fontSize: 14,
                                decoration: TextDecoration.none),
                          ),
                          flex: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Text(
                                getSafeData(UserInfoData.instance.gender).isEmpty
                                    ? "请选择"
                                    : getGender(getSafeData(UserInfoData.instance.gender)),
                                style: TextStyle(
                                    color: Colours.text_gray,
                                    fontSize: 14,
                                    decoration: TextDecoration.none))),
                        Icon(IconFonts.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
              ThemeView.divider(),
            ],
          ),
        ));
  }

  void loadSexSave(String sex) async {
    VoidViewModel.get(this, getCancelToken()).getData(
        type: VoidModel.UPDATE_GENDER,
        params2: {"gender": sex}).then((onValue) {
      setState(() {
        UserInfoData.instance.setGender(sex);
      });
      DialogUtil.buildToast("修改成功");
    });
  }

  StreamSubscription _userSubscription;

  ///监听Bus events
  void _listen() {
    _userSubscription = eventBus.on<UserInfoInEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    _listen();

    return Scaffold(
      appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
              title: "设置")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            ///头像
            _buildContainerHeader(),

            ///姓名
            _buildModifyName(),

            ///性别
            _buildSex(),

            ///密码
            _buildModifyPwd(),

            ///更换手机
            _buildChangePhone(),
            _btnExit(context)
          ],
        ),
      ),
    );
  }

  ///退出登录
  Widget _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('温馨提示'),
          content: Text('确定要退出登录吗？'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () async {
                NavigatorUtils.pop(context);
                UserInfoData.instance.setToken("");
                NavigatorUtils.goRootPage(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _btnExit(BuildContext context) {
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
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                _showExitDialog(context);
              },
              child: Container(
                width: 300.0,
                height: 50.0,
                //设置child 居中
                alignment: Alignment(0, 0),
                child: Text(
                  "退出登录",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///头像是否为空
  Widget _buildIsHasHead() {
    if (getSafeData(UserInfoData.instance.avatar).isEmpty) {
      return LoadAssetImage("icon_user",width: 28,height: 28);
    } else {
      return CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(imgUrl + getSafeData(UserInfoData.instance.avatar)));
    }
  }

  ///头像
  Container _buildContainerHeader() {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                var list = List();
                list.add('拍照');
                list.add('相册');
                return CommonBottomSheet(
                  //uses the custom alert dialog
                  list: list,
                  onItemClickListener: (index) {
                    if (index == 0) {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    } else if (index == 2) {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    }
                  },
                );
              });
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.local_florist),
                      ),
                      Expanded(
                        child: Text(
                          '头像',
                          style: TextStyle(
                              color: Colours.text_dark,
                              fontSize: 14,
                              decoration: TextDecoration.none),
                        ),
                        flex: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: _buildIsHasHead(),
                      ),
                      Icon(IconFonts.arrow_right),
                    ],
                  ),
                ],
              ),
            ),
            ThemeView.divider(),
          ],
        ),
      ),
    );
  }

  String getImageBase64(File image) {
    var bytes = image.readAsBytesSync();
    var base64 = base64Encode(bytes);
    return base64;
  }

  ///上传头像
  _pickImage(ImageSource type) async {
    File imageFile = await ImagePicker.pickImage(source: type);
    setState(() {
      primaryFile = imageFile;
    });
    if (imageFile == null) return;
    final tempDir = await getTemporaryDirectory();

    CompressObject compressObject = CompressObject(
      imageFile: imageFile, //image
      path: tempDir.path, //compress to path
      quality: 85, //first compress quality, default 80
      step:
      6, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
    );

    Luban.compressImage(compressObject).then((_path) {
      compressedFile = File(_path);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LoadingDialog(
              text: "图片上传中…",
            );
          });
      String strContent = getImageBase64(compressedFile);
      Map<String, dynamic> param = {
        "base64": strContent,
        "name": "logo.jpg",
        "type": "image/jpeg"
      };
      loadSave(param);
    });
  }

  void loadSave(Map<String, dynamic> param) async {
    fileUploadViewModel.getData(param).then((entity) {
      setState(() {
        UserInfoData.instance.setAvatar(entity.msgModel.avatar);
      });
      Navigator.pop(context);
      DialogUtil.buildToast(entity.msgModel.msg);
    });
  }

  @override
  void injectViewModelView() {
    // TODO: implement injectViewModelView

  }

}
