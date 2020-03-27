import 'package:dio/dio.dart';
import 'package:studylinjiashop/http/mvvms.dart';

class ViewModel<V extends IMvvmView> {
  V view;
  CancelToken cancelToken;
  List dataListToModel(List<dynamic> data, model) {
    List list = new List();

    data.forEach((json) => list.add(model.fromJson(json)));

    return list;
  }
}
