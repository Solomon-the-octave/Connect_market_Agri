import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._internal();
  factory LocationManager() => _instance;
  LocationManager._internal();

  String _currentLocation = 'Accra, East Legon';
  
  final List<String> availableLocations = [
    'Accra, East Legon',
    'Accra, Osu',
    'Accra, Adabraka',
    'Kumasi, Adum',
    'Kumasi, Bantama',
    'Tamale, Central',
    'Cape Coast, University',
    'Takoradi, Market Circle',
    'Ho, Bankoe',
    'Sunyani, Bono Ahafo',
    'Koforidua, New Juaben',
    'Wa, Upper West',
  ];
  
  String get currentLocation => _currentLocation;
  
  Future<void> loadUserLocation() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        
        if (doc.exists && doc.data()?['location'] != null) {
          _currentLocation = doc.data()!['location'];
        }
      }
    } catch (e) {
      // If error, keep default location
      print('Error loading user location: $e');
    }
  }
  
  Future<bool> updateLocation(String newLocation) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'location': newLocation});
        
        _currentLocation = newLocation;
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating location: $e');
      return false;
    }
  }
}
