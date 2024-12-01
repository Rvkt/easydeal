import 'package:easydeal/modules/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String base = '/';

  // todo: Route definitions with the ability to pass parameters
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      base: (context) => const DashboardScreen(),
    };
  }

  // todo: Define a route with parameters (e.g., for the register screen)
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case register:
  //     // Extract mobile parameter from arguments
  //       final String mobile = settings.arguments as String;
  //       return MaterialPageRoute(
  //         builder: (context) => RegisterScreen(mobile: mobile),
  //       );
  //
  //     case bbps:
  //     // Extract bbpsCategory parameter from arguments
  //       final String bbpsCategory = settings.arguments as String;
  //       return MaterialPageRoute(
  //         builder: (context) => BbpsScreen(bbpsCategory: bbpsCategory),
  //       );
  //
  //     case insurance:
  //     // Extract url parameter from arguments
  //       final String url = settings.arguments as String;
  //       return MaterialPageRoute(
  //         builder: (context) => InsuranceScreen(url: url), // Pass the url to InsuranceScreen
  //       );
  //     default:
  //       return MaterialPageRoute(builder: (context) => const BaseScreen());
  //   }
  // }
}
