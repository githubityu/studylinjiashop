import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studylinjiashop/common/api_exception.dart';
import 'package:studylinjiashop/common/common.dart';
import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/config/user_info_data.dart';
import 'package:studylinjiashop/http/base_response.dart';
import 'package:studylinjiashop/http/mvvms.dart';
import 'package:studylinjiashop/page/reg_and_login.dart';
import 'package:studylinjiashop/routes/application.dart';
import 'package:studylinjiashop/utils/dialog_utils.dart';

import 'dio_utils.dart';

// 请求计数
var _id = 0;

/*
* 请求类型枚举
* */
enum RequestType { GET, POST }

class ReqModel {
  // 请求url路径
  String url() => null;

  // 请求参数
  Map<String, dynamic> params() => {};

  String encodeData() => null;

  IMvvmView view;
  CancelToken cancelToken;

  /*
  * get请求
  * */
  Future<dynamic> get() async {
    return this._request(
      url: url(),
      method: RequestType.GET,
      params: params(),
    );
  }

  /*
  * post请求
  * */
  Future post() async {
    return this
        ._request(url: url(), method: RequestType.POST, params: params());
  }

  /*
  * post请求-文件上传方式
  * */
  Future postUpload(
    ProgressCallback progressCallBack, {
    FormData formData,
  }) async {
    return this._request(
      url: url(),
      method: RequestType.POST,
      formData: formData,
      progressCallBack: progressCallBack,
      params: params(),
    );
  }

  /*
  * 请求方法
  * */
  Future _request(
      {String url,
      RequestType method,
      Map params,
      FormData formData,
      ProgressCallback progressCallBack}) async {
    final httpUrl = '${API.reqUrl}$url';
    print('HTTP_REQUEST_URL::$httpUrl');

    final id = _id++;
    int statusCode;
    try {
      Response response;
      view?.showProgress();
      if (method == RequestType.GET) {
        ///组合GET请求的参数
        if (mapNoEmpty(params)) {
          response = await DioUtils.instance
              .getDio()
              .get(url, queryParameters: params, cancelToken: cancelToken);
        } else {
          response = await DioUtils.instance
              .getDio()
              .get(url, cancelToken: cancelToken);
        }
      } else {
        if (mapNoEmpty(params)) {
          response = await DioUtils.instance.getDio().post(url,
              queryParameters: params,
              data: formData,
              onSendProgress: progressCallBack,
              cancelToken: cancelToken);
        } else {
          response = await DioUtils.instance
              .getDio()
              .post(url, data: encodeData(), cancelToken: cancelToken);
        }
      }
      statusCode = response.statusCode;
      if (response != null && statusCode == 200) {
        if (mapNoEmpty(params)) print('HTTP_REQUEST_BODY::[$id]::$params');
        print('HTTP_RESPONSE_BODY::[$id]::${json.encode(response.data)}');
        BaseResponse baseResponse = BaseResponse.fromJson(response.data);
        if (baseResponse.code == 0) {
          view?.closeProgress();
          return baseResponse.data;
        } else {
           handError(baseResponse.code, msg: baseResponse.message);
        }
      }

      ///处理错误部分
      if (statusCode < 0) {
         handError(statusCode);
      }
    } catch (e) {
       handError(statusCode, msg: "$e");
    }
  }

  ///处理异常
  handError(int statusCode, {msg}) {
    DialogUtil.buildToast(msg ?? "$statusCode");
    view?.closeProgress();
    if (statusCode == -101) {
      Application.navKey.currentState.push(
        MaterialPageRoute(builder: (context) => RegPageAndLoginPage()),
      );
      UserInfoData.instance.setToken("");
      DialogUtil.buildToast("请求失败~");
    }
    throw ApiException(statusCode, msg);
  }
}
