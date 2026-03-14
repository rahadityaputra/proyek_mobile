import 'package:flutter/material.dart';
import 'package:proyek_mobile/core/app_routes.dart';
import 'package:proyek_mobile/screen/calculator_screen.dart';
import 'package:proyek_mobile/screen/dashboard_screen.dart';
import 'package:proyek_mobile/screen/login_screen.dart';
import 'package:proyek_mobile/screen/number_screen.dart';
import 'package:proyek_mobile/screen/pyramid_screen.dart';
import 'package:proyek_mobile/screen/stopwatch_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(username: 'serferjekfje'),
        );
      case AppRoutes.bilangan:
        return MaterialPageRoute(builder: (_) => NumberScreen());
      case AppRoutes.prisma:
        return MaterialPageRoute(builder: (_) => PiramidScreen());
      case AppRoutes.calculator:
        return MaterialPageRoute(builder: (_) => CalculatorScreen());
      case AppRoutes.perhitungan:
        return MaterialPageRoute(builder: (_) => NumberScreen());
      case AppRoutes.stopwatch:
        return MaterialPageRoute(builder: (_) => const StopwatchScreen());
      default:
        return MaterialPageRoute(builder: (_) => NumberScreen());
    }
  }
}
