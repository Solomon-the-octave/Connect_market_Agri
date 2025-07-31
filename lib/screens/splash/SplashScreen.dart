import 'package:flutter/material.dart';
import 'dart:async';

// Color palette matching Figma design
const primaryGreen = Color(0xFF7A8471); // Main green from Figma
const lightGreen = Color(0xFFB8C5A8); // Light green background
const darkGreen = Color(0xFF5A6B4F); // Dark green for text
const accentOrange = Color(0xFFE67E22); // Orange accent
const backgroundColor = Color(0xFFB8C5A8); // Background color

class MarketConnectSplashScreen extends StatefulWidget {
  const MarketConnectSplashScreen({super.key});

  @override
  State<MarketConnectSplashScreen> createState() => _MarketConnectSplashScreenState();
}

class _MarketConnectSplashScreenState extends State<MarketConnectSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate to landing page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/landing');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Main illustration
              Container(
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Phone illustration
                    Container(
                      width: 120,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryGreen.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // People illustrations
                    Positioned(
                      left: 0,
                      bottom: 50,
                      child: Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    
                    Positioned(
                      right: 0,
                      bottom: 30,
                      child: Container(
                        width: 50,
                        height: 70,
                        decoration: BoxDecoration(
                          color: accentOrange,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    
                    // Floating elements
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: accentOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    
                    Positioned(
                      top: 60,
                      left: 10,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: primaryGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Title and subtitle
              Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Market\n',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                            height: 1.0,
                          ),
                        ),
                        TextSpan(
                          text: 'Connect',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: darkGreen,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Connecting Farmers to Markets',
                    style: TextStyle(
                      fontSize: 16,
                      color: darkGreen.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fresh, Fast, and Fair',
                    style: TextStyle(
                      fontSize: 14,
                      color: darkGreen.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Get Started button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/landing');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
