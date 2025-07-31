import 'package:client/screens/auth/LoginScreen.dart';
import 'package:client/screens/auth/RegisterScreen.dart';
import 'package:client/screens/auth/SignupScreen.dart';
import 'package:client/screens/auth/ForgotPasswordScreen.dart';
import 'package:client/screens/splash/SplashHomePage.dart';
import 'package:client/screens/splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:client/screens/shop_screen.dart';
import 'package:client/screens/account_screen.dart';
import 'package:client/screens/explore_screen.dart';
import 'package:client/screens/favourites_screen.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/screens/settings_screen.dart';
import 'package:client/widgets/product_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MarketConnect());
}

class MarketConnect extends StatelessWidget {
  const MarketConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/landing', 
      routes: {
        '/': (context) => MarketConnectSplashScreen(),
        '/landing': (context) => MarketConnectAuthScreen(), // Onboarding
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/explore': (context) => ExploreScreen(),
        '/shop': (context) => ShopScreen(),
        '/cart': (context) => CartScreen(),
        '/favourites': (context) => FavoritesScreen(),
        '/account': (context) => AccountScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the desired screen
        Navigator.pushReplacementNamed(context, '/explore');
      },
      child: Text('Go to Home'),
    );
  }
}