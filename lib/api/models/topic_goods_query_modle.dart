import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

class TopicGoodsListModel2 extends ReqModel {
  @override
  String url() => API.topicList;

  Future data() => get();
}

class TopicGoodsQueryEntity {
  List<TopicGoodsListModel> topicGoods;

  TopicGoodsQueryEntity({this.topicGoods});

  TopicGoodsQueryEntity.fromJson(List<dynamic> json) {
    topicGoods = new List<TopicGoodsListModel>();
//			print(goods.runtimeType);
    json.forEach((v) {
      topicGoods.add(new TopicGoodsListModel.fromJson(v));
//				print(goods.length);
    });
  }
}

class TopicGoodsListModel {
  TopicGoodsModel topicGoodsModel;

  String createBy;
  String createTime;
  bool disabled;
  String id;
  String idArticle;
  String idGoodsList;
  String modifyBy;
  String modifyTime;
  String pv;
  String title;

  TopicGoodsListModel(
      {this.createBy,
      this.createTime,
      this.disabled,
      this.id,
      this.idArticle,
      this.idGoodsList,
      this.modifyBy,
      this.modifyTime,
      this.pv,
      this.title,
      this.topicGoodsModel});

  TopicGoodsListModel.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];
    createTime = json['createTime'];
    disabled = json['disabled'];
    id = json['id'];
    idArticle = json['idArticle'];
    idGoodsList = json['idGoodsList'];
    modifyBy = json['modifyBy'];
    modifyTime = json['modifyTime'];
    pv = json['pv'];
    title = json['title'];

    if (json['article'] != null) {
      topicGoodsModel = new TopicGoodsModel.fromJson(json['article']);
    }
  }
}

class TopicGoodsModel {
  String author;
  String content;
  String createBy;
  String id;
  String idChannel;
  String img;
  String createTime;
  String modifyBy;
  String modifyTime;
  String title;

  TopicGoodsModel(
      {this.author,
      this.content,
      this.createTime,
      this.id,
      this.idChannel,
      this.img,
      this.modifyBy,
      this.modifyTime,
      this.title});

  TopicGoodsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    createBy = json['createBy'];
    id = json['id'];
    idChannel = json['idChannel'];
    img = json['img'];
    createTime = json['createTime'];
    modifyBy = json['modifyBy'];
    modifyTime = json['modifyTime'];
    title = json['title'];
  }
}
