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

class MarketConnectSplashScreen extends StatelessWidget {
  const MarketConnectSplashScreen({super.key});

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.08,
                      // vertical: 40,
                    ),
                    child: Column(
                      children: [
                        // Top illustration section
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Image(image: AssetImage('assets/img1.png')),
                          ),
                        ),

                        // Title section
                        Expanded(
                          flex: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Market',
                                style: TextStyle(
                                  fontSize: _getResponsiveFontSize(context, 48),
                                  fontWeight: FontWeight.bold,
                                  color: lightTextColor,
                                  fontFamily: 'Serif',
                                ),
                              ),
                              Text(
                                'Connect',
                                style: TextStyle(
                                  fontSize: _getResponsiveFontSize(context, 32),
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Serif',
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bottom illustration and content
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // _buildBottomIllustration(context),
                              Image.asset('assets/img2.png',
                                  width: 200, height: 200),
                              SizedBox(height: 30),

                              // Description
                              Text(
                                'CONNECTING LOCAL FARMERS DIRECTLY WITH BUYERS!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: _getResponsiveFontSize(context, 12),
                                  fontWeight: FontWeight.bold,
                                  color: lightTextColor,
                                  letterSpacing: 0.5,
                                ),
                              ),

                              SizedBox(height: 15),

                              Text(
                                'Fresh, Fair, and Fast.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: _getResponsiveFontSize(context, 18),
                                  fontWeight: FontWeight.w300,
                                  color: lightTextColor,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Serif',
                                ),
                              ),

                              SizedBox(height: 40),

                              // Get Started Button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle navigation
                                    Navigator.pushNamed(
                                      context,
                                      '/landing',
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondaryGreen,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Get Started',
                                    style: TextStyle(
                                      fontSize:
                                          _getResponsiveFontSize(context, 16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
