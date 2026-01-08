import 'package:app_lapangan_futsal/screen/first_page.dart';
import 'package:app_lapangan_futsal/screen/login_screen.dart';
import 'package:app_lapangan_futsal/screen/main_screen.dart';
import 'package:app_lapangan_futsal/screen/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      // home:MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/mainscreen': (context) => const MainScreen(),
        '/signin': (context) => const LoginPage(),
        '/signup': (context) => const SignUp(),
      },
    );
  }
}
