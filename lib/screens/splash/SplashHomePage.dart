import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Updated color palette inspired by your design
const primaryGreen = Color(0xFF8B9A7A); // Sage green from your design
const primaryBlue = Color(0xFF2260FF);
const primaryBg = Color(0xFFA8B5A0); // Light sage background
const secondaryGreen = Color(0xFF6B7A5A); // Darker sage
const tertiaryGreen = Color(0xFF9DAA8C); // Medium sage
const lightCardColor = Colors.white;
const lightTextColor = Color(0xFF2C3E2D); // Dark green text
const lightSecondaryTextColor = Color(0xFF4A5A4B); // Medium green text

class MarketConnectAuthScreen extends StatelessWidget {
  const MarketConnectAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    // Top section with back button and illustration
                    Container(
                      height: constraints.maxHeight * 0.6,
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.08,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back button
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: lightTextColor,
                              size: 24,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),

                          SizedBox(height: 40),

                          // Title
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Market',
                                  style: TextStyle(
                                    fontSize:
                                        _getResponsiveFontSize(context, 48),
                                    fontWeight: FontWeight.bold,
                                    color: lightTextColor,
                                    fontFamily: 'Serif',
                                  ),
                                ),
                                Text(
                                  'Connect',
                                  style: TextStyle(
                                    fontSize:
                                        _getResponsiveFontSize(context, 32),
                                    fontWeight: FontWeight.w400,
                                    color: lightTextColor,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Serif',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 40),

                          // Illustration
                          Center(
                            child: Image.asset(
                              'assets/img2.png',
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom card section
                    Container(
                      width: double.infinity / 0.02,
                      decoration: BoxDecoration(
                        color: lightCardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, -2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Welcome text
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: _getResponsiveFontSize(context, 32),
                                fontWeight: FontWeight.bold,
                                color: lightTextColor,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              'Join MarketConnect to buy and sell fresh local produce with ease',
                              style: TextStyle(
                                fontSize: _getResponsiveFontSize(context, 16),
                                color: lightSecondaryTextColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: 32),

                            // Google Sign In Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Handle Google sign in
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Google logo
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red[500],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'G',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Continue with google',
                                      style: TextStyle(
                                        fontSize:
                                            _getResponsiveFontSize(context, 16),
                                        color: lightTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 16),

                            // Create Account Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle create account
                                  Navigator.pushNamed(
                                    context,
                                    '/register',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryGreen,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_add_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Create an account',
                                      style: TextStyle(
                                        fontSize:
                                            _getResponsiveFontSize(context, 16),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 24),

                            // Login link
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account ? ',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize:
                                        _getResponsiveFontSize(context, 14),
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                            context,
                                            '/login',
                                          );
                                        },
                                      text: 'Login',
                                      style: TextStyle(
                                        color: secondaryGreen,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375; // Base width (iPhone)
    return baseSize * scaleFactor.clamp(0.8, 1.2);
  }
}
