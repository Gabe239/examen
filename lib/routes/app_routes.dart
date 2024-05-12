import 'package:examen/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:examen/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'list': (BuildContext context) => const ListProductScreen(),
    'categoria': (BuildContext context) => const CategoriaScreen(),
    'proveedor': (BuildContext context) => const ProvidersScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
    'home': (BuildContext context) => const HomeScreen()
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
