part of 'app_pages.dart';

class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SIGNIN = _Paths.SIGNIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const SEARCH = _Paths.SEARCH;
  static const CHECKOUT = _Paths.CHECKOUT;
  static const PRODUCT = _Paths.PRODUCT;
  static const PAYMENT = _Paths.PAYMENT;
  static const PROFILE = _Paths.PROFILE;
  static const ORDER_HISTORY = _Paths.ORDER_HISTORY;
  static const CHANGE_PASSWORD = _Paths.CHANGE_PASSWORD;
  static const ALLLOCATIONS = _Paths.ALLLOCATIONS;

}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const SIGNIN = '/signin';
  static const SIGNUP = '/signup';
  static const DASHBOARD = '/dashboard';
  static const SEARCH = "/search";
  static const CHECKOUT = "/checkout";
  static const PRODUCT = "/product";
  static const PAYMENT = "/payment"; 
  static const PROFILE = "/profile";
  static const ORDER_HISTORY = "/order_history";
  static const CHANGE_PASSWORD = "/change_password";
  static const ALLLOCATIONS = "/all_locations";
}
