import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_user.dart';
import 'screens/dashboard_admin.dart';
import 'screens/game_screen.dart';
import 'models/user_model.dart';

void main() {

  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'Study Game - Thesis Management',
        debugShowCheckedModeBanner: false, 
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.black,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/dashboard_user': (context) => const DashboardUser(),
          '/dashboard_admin': (context) => const DashboardAdmin(),
          '/game': (context) => const GameScreen(),
        },
      ),
    );
  }
}