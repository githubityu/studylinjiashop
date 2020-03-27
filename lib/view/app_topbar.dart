import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:studylinjiashop/common/functions.dart';
import 'package:studylinjiashop/utils/app_size.dart';

import 'flutter_iconfont.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  final OnChangedCallback onChangedCallback;
  final FocusNode focusNode;

  SearchBar(
      {@required this.focusNode,
      @required this.controller,
      @required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: InkWell(
                child: Container(
          width: AppSize.width(750),
          height: AppSize.height(72),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: '请输入商品名称',
                contentPadding:
                    EdgeInsets.symmetric(vertical: AppSize.height(25)),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(
                    fontSize: AppSize.sp(35), color: Color(0xff999999))),
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: (str) {
              if (null != onChangedCallback) {
                onChangedCallback();
              }
            },
            focusNode: focusNode,
            controller: controller,
          ),
        ))),
      ],
    );
  }
}

class CommonTopBar extends StatelessWidget {
  final String title;

  CommonTopBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(title,
            style: TextStyle(color: Colors.white, fontSize: AppSize.sp(52))));
  }
}

class CommonBackTopBar extends StatelessWidget {
  final String title;
  final Widget leftW;
  final Widget rightW;
  final Function onLeft;
  final Function onRight;
  final bool isBack;

  CommonBackTopBar({
    @required this.title,
    this.onRight,
    this.leftW,
    this.rightW,
    this.onLeft,
    this.isBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
            child: Text(title,
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    TextStyle(color: Colors.white, fontSize: AppSize.sp(52)))),
        Positioned(
          left: 0,
          child: InkWell(
            onTap: isBack
                ? () {
                    Navigator.maybePop(context);
                  }
                : onLeft,
            child: isBack?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: AppSize.width(20)),
                  child: Icon(IconFonts.arrow_left,
                      color: Colors.white, size: AppSize.height(60)),
                )
              ],
            ):leftW,
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: onRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: AppSize.width(20)),
                  child: Icon(IconFonts.arrow_left,
                      color: Colors.white, size: AppSize.height(60)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomBackBar extends StatelessWidget {
  final Function onBack;
  final Function onAction;

  CustomBackBar({this.onBack, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: InkWell(
          onTap: onAction,
          child: Container(
            width: AppSize.width(750),
            height: AppSize.height(72),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  CupertinoIcons.search,
                  color: Color(0xff999999),
                  size: AppSize.width(40),
                ),
                Text("请输入品牌名称",
                    style: TextStyle(
                        fontSize: AppSize.sp(35), color: Color(0xff999999)))
              ],
            )),
          ),
        )),
        InkWell(
          onTap: onBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: AppSize.width(20)),
                child: Icon(IconFonts.arrow_left,
                    color: Colors.white, size: AppSize.height(60)),
              )
            ],
          ),
        )
      ],
    );
  }
}
