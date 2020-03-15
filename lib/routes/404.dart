import 'package:flutter/material.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/widget/view/load_state_layout.dart';

class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(title: "页面不存在")),
      body: LoadStateLayout(state: LoadState.State_Error,),
    );
  }
}
