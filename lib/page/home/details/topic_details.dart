import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_html/flutter_html.dart';
import 'package:studylinjiashop/api/models/topic_detail_view_model.dart';
import 'package:studylinjiashop/api/models/topic_details_model.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/view/theme_ui.dart';
import 'package:studylinjiashop/widget/view/load_state_layout.dart';

import 'topic_deatails_goods.dart';
///
/// 推荐详情页
///
class TopicDetails extends StatefulWidget {
  final String id;

  TopicDetails({this.id});

  @override
  _TopicDetailsState createState() => _TopicDetailsState();
}

class _TopicDetailsState extends State<TopicDetails> {
  final String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  LoadState _loadStateDetails = LoadState.State_Loading;
  TopicDetailsEntity topicDetailsEntity;

  @override
  void initState() {
    if (mounted) loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    topicDetailViewModel.getData(widget.id.toString()).then((entity){
      if (entity != null) {
        setState(() {
          topicDetailsEntity = entity;
          _loadStateDetails = LoadState.State_Success;
        });
      } else {
        setState(() {
          _loadStateDetails = LoadState.State_Error;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: _getHeader(),
        ),
        body: LoadStateLayout(
            state: _loadStateDetails,
            errorRetry: () {
              setState(() {
                _loadStateDetails = LoadState.State_Loading;
              });
              loadData();
            },
            successWidget: _getContent()));
  }

  ///返回不同头部
  Widget _getHeader() {
    if (null == topicDetailsEntity) {
      return CommonBackTopBar(
          title: "详情");
    } else {
      return CommonBackTopBar(
          title: topicDetailsEntity.articleModel.title);
    }
  }

  ///返回内容
  Widget _getContent() {
    if (null == topicDetailsEntity || topicDetailsEntity.goodsList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: AppSize.height(94),
            child: Text(
              topicDetailsEntity.articleModel.title,
              textAlign: TextAlign.center,
              style: ThemeTextStyle.personalShopNameStyle,
            ),
          ),
          Html(data: topicDetailsEntity.articleModel.content),
          TopicDeatilsCardGoods(topicGoods: topicDetailsEntity.goodsList)
        ],
      );
    }
  }
}
