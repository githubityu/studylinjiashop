import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:studylinjiashop/api/models/goods_modle.dart';
import 'package:studylinjiashop/api/models/hot_modle.dart';
import 'package:studylinjiashop/api/models/hot_view_model.dart';
import 'package:studylinjiashop/page/home/card_goods.dart';
import 'package:studylinjiashop/utils/app_size.dart';
import 'package:studylinjiashop/view/app_topbar.dart';
import 'package:studylinjiashop/view/customize_appbar.dart';
import 'package:studylinjiashop/widget/view/load_state_layout.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  LoadState _layoutState = LoadState.State_Loading;
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<GoodsModel> goodsList = List<GoodsModel>();
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);

    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          // ignore: missing_return
          child: SearchBar(
              focusNode: _focusNode,
              controller: _controller,
              // ignore: missing_return
              onChangedCallback: () {
                var key = _controller.text;
                if (key.isEmpty) {
                  loadData();
                } else {
                  _doSearch(key.toString());
                }
              }),
        ),
        body: LoadStateLayout(
            state: _layoutState,
            errorRetry: () {
              setState(() {
                _layoutState = LoadState.State_Loading;
              });
              _isLoading = true;
              var key = _controller.text;
              if (key.isEmpty) {
                loadData();
              } else {
                _doSearch(key.toString());
              }
            }, //错误按钮点击过后进行重新加载
            successWidget: _getContent()));
  }

  GlobalKey _headerKey = GlobalKey();
  GlobalKey _footerKey = GlobalKey();

  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    loadData();
    super.initState();
  }

  void _doSearch(String key) async {
    _isLoading = true;
    hotViewModel.getData(type: 2,key:key).then((entity) {
      if (entity?.goods != null) {
        setState(() {
          goodsList.clear();
          goodsList = entity.goods;
          _isLoading = false;
          if (goodsList.length > 0) {
            _layoutState = LoadState.State_Success;
          } else {
            _layoutState = LoadState.State_Empty;
          }
        });
      } else {
        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    });
  }

  /// 加载热门商品

  void loadData() async {
    hotViewModel.getData().then((entity) {
      if (entity?.goods != null) {
        setState(() {
          goodsList.clear();
          goodsList = entity.goods;
          _isLoading = false;
          if (goodsList.length > 0) {
            _layoutState = LoadState.State_Success;
          } else {
            _layoutState = LoadState.State_Empty;
          }
        });
      } else {
        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    });
  }

  Widget _getContent() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(
            top: AppSize.width(30),
            left: AppSize.width(30),
            right: AppSize.width(30)),
        child: EasyRefresh(
            header: MaterialHeader(
              key: _headerKey,
            ),
            footer: MaterialFooter(
              key: _footerKey,
            ),
            child: SingleChildScrollView(
                child: CardGoods(goodsModleDataList: goodsList)),
            onRefresh: () async {
              _isLoading = true;
              var name = _controller.text;
              if (name.isEmpty) {
                loadData();
              } else {
                _doSearch(name.toString());
              }
            },
            onLoad: () async {}),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
