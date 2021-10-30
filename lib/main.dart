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
            '[n]https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/2c90bb65-3c93-4f38-8f43-0469c153c1e0/detpi9z-fdc4ce3a-8907-4733-9d4a-ba79e61bbeb6.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzJjOTBiYjY1LTNjOTMtNGYzOC04ZjQzLTA0NjljMTUzYzFlMFwvZGV0cGk5ei1mZGM0Y2UzYS04OTA3LTQ3MzMtOWQ0YS1iYTc5ZTYxYmJlYjYucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.uNl3N1ZJQUwvvnX6j83GikxSpLTZMUSD1rqe0Q8vWiM',
        nextScreen: SplashScreen(),
        backgroundColor: Color(0xFF45D1FD),
        splashTransition: SplashTransition.scaleTransition,
        duration: 5000,
        splashIconSize: 300,
      ),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
    );
  }
}
