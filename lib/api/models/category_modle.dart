import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

class CategoryModel2 extends ReqModel {
  @override
  String url() => API.categoryList;

  Future data() => get();
}

class CategoryEntity {
  List<CategoryModel> category;

  CategoryEntity({this.category});

  CategoryEntity.fromJson(List<dynamic> json) {
    category = new List<CategoryModel>();
    json.forEach((v) {
      category.add(new CategoryModel.fromJson(v));
    });
  }
}

class CategoryModel {
  String name;
  String id;
  List<CategoryInfoModel> categoryInfoModels;

  CategoryModel({this.name, this.id, this.categoryInfoModels});

  factory CategoryModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['bannerList'] as List;

    List<CategoryInfoModel> categoryInfoList =
        list.map((i) => CategoryInfoModel.fromJson(i)).toList();
    return CategoryModel(
        id: parsedJson['id'],
        name: parsedJson['name'],
        categoryInfoModels: categoryInfoList);
  }
}

class CategoryInfoModel {
  String createBy;
  String createTime;
  String idFile;
  String modifyBy;
  String modifyTime;
  String title;
  String type;
  String url;
  String id;
  String page;
  String param;

  CategoryInfoModel(
      {this.createBy,
      this.createTime,
      this.idFile,
      this.modifyBy,
      this.modifyTime,
      this.title,
      this.type,
      this.url,
      this.id,
      this.page});

  CategoryInfoModel.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];
    createTime = json['createTime'];
    idFile = json['idFile'];
    modifyBy = json['modifyBy'];
    modifyTime = json['modifyTime'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    id = json['id'];
    page = json['page'];
    param = json['param'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['idFile'] = this.idFile;
    data['modifyBy'] = this.modifyBy;
    data['modifyTime'] = this.modifyTime;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['id'] = this.id;
    data['page'] = this.page;
    return data;
  }
}
