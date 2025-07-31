import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connect_market_agri/screens/splash/SplashHomePage.dart';
import 'package:connect_market_agri/screens/splash/SplashScreen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is not signed in
        if (!snapshot.hasData) {
          return const MarketConnectSplashScreen();
        }

        // User is signed in
        return const MarketConnectAuthScreen(); 
      },
    );
  }
}
