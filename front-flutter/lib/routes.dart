import 'package:flutter/material.dart';
import 'package:untitled2/screens/add_users_screen.dart';
import 'package:untitled2/screens/reset_password_screen.dart';
import 'package:untitled2/screens/update_user_screen.dart';
import 'package:untitled2/screens/users_list_screen.dart';

import 'screens/login_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/register_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String mainMenu = '/mainmenu';
  static const String userList = '/list';
  static const String addUser = '/add';
  static const String updateUser = '/updateUser';
  static const String passwordReset = '/passwordReset';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case mainMenu:
        return MaterialPageRoute(builder: (_) => MainMenuScreen());
      case userList:
        return MaterialPageRoute(builder: (_) => UsersListScreen());
      case addUser:
        return MaterialPageRoute(builder: (_) => AddUserScreen());
      case AppRoutes.passwordReset:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case updateUser:
        return MaterialPageRoute(
            builder: (_) =>
                UpdateUserScreen(user_id: settings.arguments as int));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: Center(child: Text('Not Found'))));
    }
  }
}
