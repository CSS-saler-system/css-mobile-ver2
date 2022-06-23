import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentations/edit_customer/edit_customer_screen.dart';
import 'package:flutter_application_1/src/presentations/main/main_screen.dart';
import 'package:flutter_application_1/src/presentations/sign_in/sign_in_screen.dart';

import '../../presentations/create_customer/create_customer_screen.dart';
import '../../presentations/customer/customer_screen.dart';
import '../../presentations/edit_profile/edit_profile_screen.dart';
import '../../presentations/list_product/list_product_screen.dart';
import '../../presentations/order_detail/order_detail_screen.dart';
import '../../presentations/otp_confirm/otp_confirm_screen.dart';
import '../../presentations/product_detail/product_detail_screen.dart';

class AppRouters {
  static const String signIn = "/sign_in";
  static const String otpConfirm = "/otp_confirm";
  static const String mainScreen = "/main_screen";
  static const String editProfile = "/edit_profile";
  static const String customerScreen = "/customer_screen";
  static const String createCustomerScreen = "/create_customer_screen";
  static const String productDetail = "/product_detail";
  static const String orderDetail = "/order_detail";
  static const String listProduct = "/list_product";
  static const String editCustomerScreen = "/edit_customer_screen";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map arguments =
        settings.arguments != null ? (settings.arguments as Map) : {};
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case mainScreen:
        return MaterialPageRoute(
            builder: (_) => MainScreen(pageIndex: arguments["pageIndex"]));
      case otpConfirm:
        return MaterialPageRoute(
            builder: (_) => const OtpConfirmScreen(verificationId: ""));
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case customerScreen:
        return MaterialPageRoute(builder: (_) => const CustomerScreen());
      case createCustomerScreen:
        return MaterialPageRoute(builder: (_) => const CreateCustomerScreen());
      case orderDetail:
        return MaterialPageRoute(
            builder: (_) => OrderDetailScreen(orderId: arguments["orderId"]));
      case productDetail:
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailScreen(productId: arguments["productId"].toString()));
      case listProduct:
        return MaterialPageRoute(builder: (_) => const ListProductScreen());
      case editCustomerScreen:
        return MaterialPageRoute(
            builder: (_) =>
                EditCustomerScreen(customerId: arguments["customerId"]));
      default:
        return animRoute(
            Center(child: Text('No route defined for ${settings.name}')),
            name: "/error");
    }
  }

  static Route animRoute(Widget page,
      {Offset? beginOffset, required String name, Object? arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? const Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static const Offset _center = Offset(0.0, 0.0);
  static const Offset _top = Offset(0.0, 1.0);
  static const Offset _bottom = Offset(0.0, -1.0);
  static const Offset _left = Offset(-1.0, 0.0);
  static const Offset _right = Offset(1.0, 0.0);
}
