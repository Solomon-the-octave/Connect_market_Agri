import 'package:client/screens/auth/LoginScreen.dart';
import 'package:client/screens/auth/RegisterScreen.dart';
import 'package:client/screens/splash/SplashHomePage.dart';
import 'package:client/screens/splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FamCare());
}

class FamCare extends StatelessWidget {
  const FamCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MarketConnectSplashScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/landing': (context) => MarketConnectAuthScreen(),
      },
    );
  }
}
