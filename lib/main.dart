import 'package:easydeal/modules/store/cart_screen.dart';
import 'package:easydeal/modules/dashboard/dashboard_screen.dart';
import 'package:easydeal/provider/cart_provider.dart';
import 'package:easydeal/provider/location_provider.dart';
import 'package:easydeal/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Restrict app to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'EaseMyDeal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.base,
        routes: AppRoutes.getRoutes(),
        // onGenerateRoute: AppRoutes.generateRoute,
        // home: const CartScreen(),
      ),
    );
  }
}