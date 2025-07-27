import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketconnect/screens/SplashHomePage.dart';
import 'package:marketconnect/screens/SplashScreen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading indicator while waiting for connection
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // User is not signed in
        if (!snapshot.hasData) {
          return const SplashScreen();
        }

        // User is signed in
        return const SplashHomePage();
      },
    );
  }
}
