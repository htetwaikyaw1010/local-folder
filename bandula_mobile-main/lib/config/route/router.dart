import 'package:flutter/material.dart';
import 'package:bandula/core/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import 'package:bandula/core/viewobject/holder/intent_holder/products_by_brand_intent_holder.dart';
import 'package:bandula/screen/cart/view/success_screen.dart';
import 'package:bandula/screen/category/view/category_details_view.dart';

import 'package:bandula/screen/order/view/order_details_screen.dart';
import 'package:bandula/screen/product/view/produch_search.dart';
import 'package:bandula/screen/product/view/product_details.dart';
import 'package:bandula/screen/product/view/products_by_brand.dart';
import 'package:bandula/screen/user/signup/signup_screen.dart';

import '../../core/viewobject/holder/intent_holder/category_detail_intent_holder.dart';
import '../../core/viewobject/holder/intent_holder/order_checkout_intent_holder.dart';
import '../../core/viewobject/holder/intent_holder/order_detail_intent_holder.dart';
import '../../screen/cart/view/cart_screen.dart';
import '../../screen/cart/view/checkout_manual_screen.dart';
import '../../screen/loginorsignup/login_or_signup_view.dart';
import '../../screen/order/view/order_history_screen.dart';
import '../../screen/region/view/select_region_screen.dart';
import '../../screen/user/Login/login_screen.dart';
import '../../screen/app_loading/view/app_loading_screen.dart';
import '../../screen/dashboard/view/dashboard_view.dart';
import '../../screen/user/change_passowrd/change_password_screen.dart';
import 'route_paths.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const AppLoadingView();
      });

    case RoutePaths.home:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.home),
          builder: (BuildContext context) {
            return const DashboardView();
          });
    case RoutePaths.login:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.login),
          builder: (BuildContext context) {
            return const LoginScreen();
          });
    case RoutePaths.loginOrSignup:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.loginOrSignup),
          builder: (BuildContext context) {
            return const LoginOrSignUpView();
          });

    case RoutePaths.signUp:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.signUp),
          builder: (BuildContext context) {
            return const SignUpScreen();
          });
    case RoutePaths.changePassword:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.changePassword),
          builder: (BuildContext context) {
            return const ChangePasswordScreen();
          });
    case RoutePaths.selectRegion:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.selectRegion),
          builder: (BuildContext context) {
            return const SelectRegionScreen();
          });
    case RoutePaths.manualCheckout:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: RoutePaths.manualCheckout),
        builder: (BuildContext context) {
          final Object? args = settings.arguments;
          final OrderCheckoutIntentHolder holder =
              args as OrderCheckoutIntentHolder;
          return CheckoutManualScreen(
            region: holder.region,
            name: holder.name,
            phone: holder.phone,
            address: holder.address,
            totalFee: holder.totalFee,
            fees: holder.fees,
            paymentName: holder.paymentName,
            regionId: holder.region,
          );
        },
      );
    case RoutePaths.successScreen:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.successScreen),
          builder: (BuildContext context) {
            return const SuccessfulScreen();
          });
    case RoutePaths.categoryDetails:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.categoryDetails),
          builder: (BuildContext context) {
            final Object? args = settings.arguments;
            final CategoryDetailIntentHolder holder =
                args as CategoryDetailIntentHolder;

            return CategoryDetailsView(
              title: holder.title,
              id: holder.id,
            );
          });
    case RoutePaths.productDetails:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.productDetails),
          builder: (BuildContext context) {
            final Object? args = settings.arguments;
            final ProductDetailsIntentHolder holder =
                args as ProductDetailsIntentHolder;
            return ProductDetailsView(
              productID: holder.product.id.toString(),
            );
          });
    case RoutePaths.productsByBrand:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.productsByBrand),
          builder: (BuildContext context) {
            final Object? args = settings.arguments;
            final ProductsByBrandIntentHolder holder =
                args as ProductsByBrandIntentHolder;
            return ProductsByBrandView(
              title: holder.title,
              id: holder.id,
              catID: holder.catID,
              name: holder.title,
            );
          });

    case RoutePaths.productSearch:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.productSearch),
          builder: (BuildContext context) {
            return const ProductsSearchScreen();
          });
    case RoutePaths.orderHistory:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.orderHistory),
          builder: (BuildContext context) {
            return const OrderHistoryScreen();
          });
    case RoutePaths.orderDetails:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.orderDetails),
          builder: (BuildContext context) {
            final Object? args = settings.arguments;
            final OrderDetailsIntentHolder holder =
                args as OrderDetailsIntentHolder;
            return OrderDetailScreen(
              orderID: holder.id,
            );
          });
    case RoutePaths.cart:
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.cart),
          builder: (BuildContext context) {
            return const CartScreen();
          });
    default:
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              const AppLoadingView());
  }
}
