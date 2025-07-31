import 'package:flutter/material.dart';

// Color palette matching Figma design
const primaryGreen = Color(0xFF7A8471);
const lightGreen = Color(0xFFB8C5A8);
const darkGreen = Color(0xFF5A6B4F);
const accentOrange = Color(0xFFE67E22);
const backgroundColor = Color(0xFFB8C5A8);
const primaryBg = backgroundColor;
const lightTextColor = Colors.white;
const lightCardColor = Color(0xFFEFF3EA);
const lightSecondaryTextColor = Color(0xFF7A8471);

class MarketConnectAuthScreen extends StatelessWidget {
  const MarketConnectAuthScreen({super.key});

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375; // Base width (iPhone)
    return baseSize * scaleFactor.clamp(0.8, 1.2);
  }

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
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Top section with back button and illustration
                      Container(
                        // Use fraction of maxHeight for responsiveness
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
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom card section
                      Expanded(
                        child: Container(
                          width: double.infinity,
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
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Welcome text
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontSize:
                                        _getResponsiveFontSize(context, 32),
                                    fontWeight: FontWeight.bold,
                                    color: lightTextColor,
                                  ),
                                ),

                                SizedBox(height: 12),

                                Text(
                                  'Join MarketConnect to buy and sell fresh local produce with ease',
                                  style: TextStyle(
                                    fontSize:
                                        _getResponsiveFontSize(context, 16),
                                    color: lightSecondaryTextColor,
                                    height: 1.4,
                                  ),
                                ),

                                SizedBox(height: 32),

                                // Create an account button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/register');
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
                                      'Create an account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 24),

                                // Login link
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: darkGreen,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
