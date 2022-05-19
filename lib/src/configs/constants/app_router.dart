import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentations/sign_in/sign_in_screen.dart';

import '../../presentations/otp_confirm/otp_confirm_screen.dart';

class AppRouters {
  static const String signIn = "/sign_in";
  static const String otpConfirm = "/otp_confirm";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case otpConfirm:
        return MaterialPageRoute(builder: (_) => const OtpConfirmScreen(verificationId: "",));
      default:
        return animRoute(
            Container(
                child: Center(
                    child: Text('No route defined for ${settings.name}'))),
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

  static final Offset _center = Offset(0.0, 0.0);
  static final Offset _top = Offset(0.0, 1.0);
  static final Offset _bottom = Offset(0.0, -1.0);
  static final Offset _left = Offset(-1.0, 0.0);
  static final Offset _right = Offset(1.0, 0.0);
}
