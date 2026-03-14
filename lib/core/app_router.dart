import 'package:flutter/material.dart';
import 'package:proyek_mobile/core/app_routes.dart';
import 'package:proyek_mobile/screen/about_screen.dart';
import 'package:proyek_mobile/screen/calculator_screen.dart';
import 'package:proyek_mobile/screen/character_analysis_screen.dart';
import 'package:proyek_mobile/screen/dashboard_screen.dart';
import 'package:proyek_mobile/screen/login_screen.dart';
import 'package:proyek_mobile/screen/number_screen.dart';
import 'package:proyek_mobile/screen/pyramid_screen.dart';
import 'package:proyek_mobile/screen/stopwatch_screen.dart';
import 'package:proyek_mobile/screen/weton_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(fullname: 'rahaditya abimanyu putra'),
        );
      case AppRoutes.bilangan:
        return MaterialPageRoute(builder: (_) => NumberScreen());
      case AppRoutes.pyramid:
        return MaterialPageRoute(builder: (_) => PiramidScreen());
      case AppRoutes.calculator:
        return MaterialPageRoute(builder: (_) => CalculatorScreen());
      case AppRoutes.stopwatch:
        return MaterialPageRoute(builder: (_) => const StopwatchScreen());
      case AppRoutes.characterMap:
        return MaterialPageRoute(builder: (_) => CharacterAnalysisScreen());
      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case AppRoutes.jawa:
        return MaterialPageRoute(builder: (_) => WetonScreen());
      default:
        return MaterialPageRoute(builder: (_) => NumberScreen());
    }
  }
}
