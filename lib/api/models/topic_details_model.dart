
import 'package:studylinjiashop/config/api.dart';
import 'package:studylinjiashop/http/req_model.dart';

/// 推荐详情页面

class TopicDetailModel extends ReqModel {
	String id;

	@override
	String url() => "${API.topicDetail}$id";


	Future data(id) {
		this.id = id;
		return get();
	}

}


class TopicDetailsEntity {
	ArticleModel articleModel;
	List<TopGoods>   goodsList;
	TopicDetailsEntity({this.articleModel,this.goodsList});
	TopicDetailsEntity.fromJson(Map<String, dynamic> json) {
		goodsList = new List<TopGoods>();
		if(json['article'] !=null) {
			articleModel = ArticleModel.fromJson(json['article']);
		}
		List<Map> dataList= (json['goodsList'] as List).cast();
		dataList.forEach((v){
			goodsList.add(new TopGoods.fromJson(v));
		});
	}

}
class ArticleModel{
	String title;
	String content;
	ArticleModel.fromJson(Map<String, dynamic> json){
		title=json['title'];
		content=json['content'];
	}

}
class TopGoods {
	String name;
	String pic;
	String id;
	TopGoods.fromJson(Map<String, dynamic> json){
		name = json['name'];
		pic = json['pic'];
		id = json['id'];
	}
}

