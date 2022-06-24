import 'package:flutter/material.dart';
import 'package:proyecto_vijap/models/menu_option.dart';
import 'package:proyecto_vijap/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'listview2',
        name: 'Personas Encontradas',
        screen: const Listview2Screen(),
        icon: Icons.list),
    MenuOption(
        route: 'alert',
        name: 'Crear Aviso',
        screen: const AlertScreen(),
        icon: Icons.add_photo_alternate_sharp),
    MenuOption(
        route: 'card',
        name: 'Personas Desaparecidas',
        screen: const CardScreen(),
        icon: Icons.person_off_sharp),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'login': (BuildContext context) => const LoginScreen()});
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});
    appRoutes.addAll({'sign': (BuildContext context) => SignInScreen()});
    appRoutes
        .addAll({'input': (BuildContext constext) => const InputsScreen()});
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  // static Map<String, Widget Function(BuildContext)> routes = {
  //   'home': (context) => const HomeScreen(),
  //   'listview1': (context) => const Listview1Screen(),
  //   'listview2': (context) => const Listview2Screen(),
  //   'alert': (context) => const AlertScreen(),
  //   'card': (context) => const CardScreen()
  // };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
