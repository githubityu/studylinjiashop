import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:studylinjiashop/api/models/category_modle.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';

import 'package:studylinjiashop/routes/shop_router.dart';

/**
 * 轮播组件
 */
class SwiperDiy extends StatelessWidget {
  final List<CategoryInfoModel> swiperDataList;
  final double height;
  final double width;

  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  SwiperDiy({Key key, this.swiperDataList, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: () {
                  if (swiperDataList[index].page.isNotEmpty) {
                    if (swiperDataList[index].page.startsWith("http") ||
                        swiperDataList[index].page.startsWith("https")) {
                      _goWeb(context, swiperDataList[index].page,swiperDataList[index].title);
                    } else if ("goods" == swiperDataList[index].page) {
                      Map<String, dynamic> result =
                          jsonDecode(swiperDataList[index].param);
                      if (result.containsKey("id")) {
                        _goDetail(context, result['id'].toString());
                      }
                    }
                  }
                },
                child: Image.network(
                  imgUrl + "${swiperDataList[index].idFile}",
                  fit: BoxFit.cover,
                ),
              ));
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(margin: EdgeInsets.all(1.0)),
        autoplay: true,
      ),
    );
  }

  void _goWeb(BuildContext context, String url, String title) {
    NavigatorUtils.goWebViewPage(context, title, url);
  }

  void _goDetail(BuildContext context, String id) {
    NavigatorUtils.push(context, ShopRouter.PRODUCT_DETAILS, params:{"id": id});
  }
}
