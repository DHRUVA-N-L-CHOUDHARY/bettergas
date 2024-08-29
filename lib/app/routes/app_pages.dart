import 'package:bettergas_assignment/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:bettergas_assignment/app/modules/change_password/views/change_password_view.dart';
import 'package:bettergas_assignment/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:bettergas_assignment/app/modules/dashboard/views/dashboard_view.dart';
import 'package:bettergas_assignment/app/modules/orders_history/views/order_history_view.dart';
import 'package:bettergas_assignment/app/modules/payment/views/payment_view.dart';
import 'package:bettergas_assignment/app/modules/product/views/product_view.dart';
import 'package:bettergas_assignment/app/modules/profile/bindings/Profile_binding.dart';
import 'package:bettergas_assignment/app/modules/profile/views/profile_view.dart';
import 'package:bettergas_assignment/app/modules/search/bindings/all_locations_bindings.dart';
import 'package:bettergas_assignment/app/modules/search/views/all_locations_view.dart';
import 'package:bettergas_assignment/app/modules/search/views/searchview.dart';
import 'package:bettergas_assignment/app/modules/sign_in/views/sign_in_screen.dart';
import 'package:bettergas_assignment/app/modules/splash/views/splash_view.dart';
import 'package:get/get.dart';
import '../modules/orders_history/bindings/order_history_binding.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/search/bindings/search_bindings.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_screen.dart';
import '../modules/splash/bindings/splash_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const SIGNIN = Routes.SIGNIN;
  static const SIGNUP = Routes.SIGNUP;
  static const DASHBOARD = Routes.DASHBOARD;
  static const SEARCH = Routes.SEARCH;
  static const CHECKOUT = Routes.CHECKOUT;
  static const PRODUCT = Routes.PRODUCT;
  static const SPLASH = Routes.SPLASH;
  static const PAYMENT = Routes.PAYMENT;
  static const PROFILE = Routes.PROFILE;
  static const ORDER_HISTORY = Routes.ORDER_HISTORY;
  static const CHANGE_PASSWORD = Routes.CHANGE_PASSWORD;
  static const ALLLOCATIONS = Routes.ALLLOCATIONS;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashBoardView(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.ALLLOCATIONS,
      page: () => const AllLocationsView(),
      binding: AllLocationsBinding(),
    ),
  ];
}
