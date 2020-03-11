import 'package:studylinjiashop/common/common.dart';
import 'package:studylinjiashop/utils/utils.dart';

class UserInfoData {
  //用户相关信息
  String _token = "";
  static UserInfoData _instance;
  bool isUser = false;
  int orderIndex = 0;
  String gender = '';
  String avatar = '';
  String mobile = '';
  String nickName = '';

  factory UserInfoData() => _getInstance();

  static UserInfoData get instance => _getInstance();

  UserInfoData._internal() {
    // 初始化
  }

  static UserInfoData _getInstance() {
    if (_instance == null) {
      _instance = new UserInfoData._internal();
    }
    return _instance;
  }

  void setToken(token) {
    SharedUtil.instance.saveString("token", token);
    this._token = token;
  }

  get isLogin {
    return _token != null && _token.isNotEmpty;
  }

  setNickName(String name) {
    nickName = name;
    SharedUtil.instance.saveString("nickName", name);
  }

  setAvatar(String _avatar) {
    avatar = _avatar;
    SharedUtil.instance.saveString("nickName", _avatar);
  }

  setGender(String _gender) {
    gender = _gender;
    SharedUtil.instance.saveString("nickName", _gender);
  }

  String get token {
    _token = getSafeData(SharedUtil.instance.getString("token"));
    return _token;
  } //访问属性

}
