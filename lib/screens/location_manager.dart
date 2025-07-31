import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._internal();
  factory LocationManager() => _instance;
  LocationManager._internal();

  String _currentLocation = 'Dhaka, Banasree';
  
  final List<String> availableLocations = [
    'Dhaka, Banasree',
    'Dhaka, Dhanmondi',
    'Dhaka, Gulshan',
    'Dhaka, Uttara',
    'Chittagong, Agrabad',
    'Chittagong, Nasirabad',
    'Sylhet, Zindabazar',
    'Rajshahi, Shaheb Bazar',
    'Khulna, Sonadanga',
    'Barisal, Sadar',
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
