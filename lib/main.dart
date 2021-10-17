import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/pages/home/home_screen.dart';
import 'package:online_shop/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_shop/pages/splash/splash_screen.dart';
import 'package:online_shop/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: AnimatedSplashScreen(
        splash:
            '[n]https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/2c90bb65-3c93-4f38-8f43-0469c153c1e0/dem0uc2-5da159f2-44d4-4e53-bb91-6aa87ea3d803.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzJjOTBiYjY1LTNjOTMtNGYzOC04ZjQzLTA0NjljMTUzYzFlMFwvZGVtMHVjMi01ZGExNTlmMi00NGQ0LTRlNTMtYmI5MS02YWE4N2VhM2Q4MDMucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.6zUD9t5VkPwp7wY7KiV0NDfY1y8QXmpkUenCfIV20is',
        nextScreen: SplashScreen(),
        backgroundColor: Color(0xFF07080A),
        splashTransition: SplashTransition.scaleTransition,
        duration: 10000,
        splashIconSize: 300,
      ),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
    );
  }
}
