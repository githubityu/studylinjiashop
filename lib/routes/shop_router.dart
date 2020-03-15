import 'package:fluro/fluro.dart';
import 'package:studylinjiashop/page/guide_page.dart';
import 'package:studylinjiashop/page/home/details/order_details.dart';
import 'package:studylinjiashop/page/home/details/product_details.dart';
import 'package:studylinjiashop/page/home/details/topic_details.dart';
import 'package:studylinjiashop/page/member/modify_name_page.dart';
import 'package:studylinjiashop/page/member/modify_pwd_page.dart';
import 'package:studylinjiashop/page/member/setting_page.dart';
import 'package:studylinjiashop/page/member/shipping_address.dart';
import 'package:studylinjiashop/page/member/shipping_edit_address.dart';
import 'package:studylinjiashop/page/member/shipping_save_address.dart';
import 'package:studylinjiashop/page/order/orderform_page.dart';
import 'package:studylinjiashop/page/order/pay_page.dart';
import 'package:studylinjiashop/page/reg_and_login.dart';
import 'package:studylinjiashop/page/root/root_page.dart';
import 'package:studylinjiashop/routes/router_init.dart';

class ShopRouter implements IRouterProvider {
  // details
  static const ORDER_DETAILS = '/order_details';
  static const PRODUCT_DETAILS = '/product_details';

  static const login_page = '/login_page';
  static const root_page = '/root_page';
  static const guide_page = '/guide_page';
  static const order_page = '/order_page';
  static const pay_page = '/pay_page';
  static const address_page = '/address_page';
  static const save_address_page = '/save_address_page';
  static const new_address_page = '/new_address_page';
  static const topic_page = '/topic';
  static const setting_page = '/setting';
  static const modify_name_page = '/modify_name';
  static const modify_pwd_page = '/modify_pwd';

  @override
  void initRouter(Router router) {
    router.define(login_page,
        handler:
            Handler(handlerFunc: (context, params) => RegPageAndLoginPage()));
    router.define(root_page,
        handler: Handler(handlerFunc: (context, params) => RootPage()));
    router.define(guide_page,
        handler: Handler(handlerFunc: (context, params) => GuidePage()));
    router.define(PRODUCT_DETAILS,
        handler: Handler(
            handlerFunc: (context, params) =>
                ProductDetails(id: params['id'].first)));
    router.define(ORDER_DETAILS,
        handler: Handler(
            handlerFunc: (context, params) =>
                OrderDetails(orderSn: params['orderSn'].first)));
    router.define(topic_page,
        handler: Handler(
            handlerFunc: (context, params) =>
                TopicDetails(id: params['id'].first)));
    router.define(order_page,
        handler: Handler(handlerFunc: (context, params) => OrderFormPage()));
    router.define(pay_page,
        handler: Handler(
            handlerFunc: (context, params) => PayPage(
                orderSn: params['orderSn'].first,
                totalPrice: params['totalPrice'].first)));

    router.define(address_page,
        handler:
            Handler(handlerFunc: (context, params) => ShippingAddressPage()));
    router.define(save_address_page,
        handler: Handler(
            handlerFunc: (context, params) =>
                ShippingEditAddressPage(id: params['id'].first)));

    router.define(new_address_page,
        handler: Handler(
            handlerFunc: (context, params) => ShippingSaveAddressPage()));
    router.define(setting_page,
        handler: Handler(handlerFunc: (context, params) => SettingPage()));
    router.define(modify_name_page,
        handler: Handler(
            handlerFunc: (context, params) => ModifyNamePage(
                  name: params['name'].first,
                )));
    router.define(modify_pwd_page,
        handler: Handler(handlerFunc: (context, params) => ModifyPwdPage()));
  }
}
