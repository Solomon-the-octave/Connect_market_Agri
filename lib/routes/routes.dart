import 'package:flutter/material.dart';
import 'package:client/screens/splash/SplashScreen.dart';
import 'package:client/screens/splash/SplashHomePage.dart';
import 'package:client/screens/auth/LoginScreen.dart';
import 'package:client/screens/auth/RegisterScreen.dart';
import 'package:client/screens/shop_screen.dart';
import 'package:client/screens/account_screen.dart';
import 'package:client/screens/explore_screen.dart';
import 'package:client/screens/favourites_screen.dart';
import 'package:client/screens/cart_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => MarketConnectSplashScreen(), // Splash screen
  '/landing': (context) => MarketConnectAuthScreen(), // Onboarding screen
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/shop': (context) => ShopScreen(),
  '/account': (context) => AccountScreen(),
  '/explore': (context) => ExploreScreen(),
  '/favourites': (context) => FavoritesScreen(),
  '/cart': (context) => CartScreen(),
};