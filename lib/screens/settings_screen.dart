import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/bottom_nav_bar.dart'; 

// Color constants
const primaryGreen = Color(0xFF8B9A7A);
const backgroundColor = Color(0xFFB8C5A8);
const darkGreen = Color(0xFF2C3E2D);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationServicesEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  bool _autoBackupEnabled = false;
  String _defaultCurrency = 'GHS';

  final List<String> _languages = ['English', 'Twi', 'Ga', 'Ewe', 'Hausa'];
  final List<String> _currencies = ['GHS', 'USD', 'EUR', 'GBP'];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _locationServicesEnabled = prefs.getBool('location_services_enabled') ?? true;
      _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
      _selectedLanguage = prefs.getString('selected_language') ?? 'English';
      _autoBackupEnabled = prefs.getBool('auto_backup_enabled') ?? false;
      _defaultCurrency = prefs.getString('default_currency') ?? 'GHS';
    });
  }

  // Save individual preference
  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
    
    // Show confirmation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preference saved successfully'),
          backgroundColor: primaryGreen,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGreen),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: primaryGreen.withOpacity(0.2),
                    child: Icon(Icons.person, size: 40, color: primaryGreen),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? 'user@example.com',
                    style: const TextStyle(fontSize: 16, color: Color(0xFF4A5A4B)),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        final userData = snapshot.data!.data() as Map<String, dynamic>;
                        final userType = userData['type'] as String? ?? 'buyer';
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: userType == 'farmer' ? Colors.green : primaryGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            userType.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    Icons.notifications_outlined,
                    'Push Notifications',
                    'Receive notifications about orders and updates',
                    Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                        _savePreference('notifications_enabled', value);
                      },
                      activeColor: primaryGreen,
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.location_on_outlined,
                    'Location Services',
                    'Allow app to access your location',
                    Switch(
                      value: _locationServicesEnabled,
                      onChanged: (value) {
                        setState(() {
                          _locationServicesEnabled = value;
                        });
                        _savePreference('location_services_enabled', value);
                      },
                      activeColor: primaryGreen,
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.language_outlined,
                    'Language',
                    'Select your preferred language',
                    DropdownButton<String>(
                      value: _selectedLanguage,
                      underline: const SizedBox(),
                      items: _languages.map((language) {
                        return DropdownMenuItem(value: language, child: Text(language));
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLanguage = newValue;
                          });
                          _savePreference('selected_language', newValue);
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.dark_mode_outlined,
                    'Dark Mode',
                    'Switch to dark theme',
                    Switch(
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                        _savePreference('dark_mode_enabled', value);
                      },
                      activeColor: primaryGreen,
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.backup_outlined,
                    'Auto Backup',
                    'Automatically backup your data',
                    Switch(
                      value: _autoBackupEnabled,
                      onChanged: (value) {
                        setState(() {
                          _autoBackupEnabled = value;
                        });
                        _savePreference('auto_backup_enabled', value);
                      },
                      activeColor: primaryGreen,
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.attach_money_outlined,
                    'Default Currency',
                    'Select your preferred currency',
                    DropdownButton<String>(
                      value: _defaultCurrency,
                      underline: const SizedBox(),
                      items: _currencies.map((currency) {
                        return DropdownMenuItem(value: currency, child: Text(currency));
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            _defaultCurrency = newValue;
                          });
                          _savePreference('default_currency', newValue);
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.security_outlined,
                    'Privacy & Security',
                    'Manage your privacy settings',
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () => _showPrivacyDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildSettingItem(
                    Icons.info_outline,
                    'About App',
                    'Version info and app details',
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () => _showAboutDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/landing',
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  foregroundColor: darkGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: darkGreen),
                    const SizedBox(width: 8),
                    const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    Widget trailing, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryGreen, size: 24),
      title: Text(title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: darkGreen,
          )),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 14, color: Color(0xFF4A5A4B))),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Privacy & Security'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data Protection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(
              '• Your personal information is encrypted and secure\n'
              '• Payment details are never stored on our servers\n'
              '• Location data is only used for delivery purposes\n'
              '• You can delete your account anytime',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text('Account Security', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(
              '• Two-factor authentication available\n'
              '• Regular security updates\n'
              '• Secure login with Firebase Auth',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('About Connect Market Agri'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version 1.0.0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Connect Market Agri is Ghana\'s premier agricultural marketplace connecting farmers directly with buyers.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text('Features:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 8),
            Text(
              '• Direct farmer-to-buyer connections\n'
              '• Secure payment processing\n'
              '• Real-time order tracking\n'
              '• Multiple payment methods\n'
              '• Location-based delivery',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text('© 2024 Connect Market Agri\nMade in Ghana 🇬🇭',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}
