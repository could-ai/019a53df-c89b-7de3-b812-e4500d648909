import 'package:flutter/foundation.dart';
import '../models/location.dart';

class LocationService extends ChangeNotifier {
  final List<Location> _locations = [
    Location(
      id: '1',
      name: 'Downtown Area',
      address: '123 Main Street',
      latitude: 40.7128,
      longitude: -74.0060,
      restaurantId: 'rest1',
    ),
    Location(
      id: '2',
      name: 'Uptown District',
      address: '456 Park Avenue',
      latitude: 40.7829,
      longitude: -73.9654,
      restaurantId: 'rest1',
    ),
    Location(
      id: '3',
      name: 'Suburb Area',
      address: '789 Oak Street',
      latitude: 40.6782,
      longitude: -73.9442,
      isBlocked: true,
      restaurantId: 'rest1',
    ),
  ];

  List<Location> get locations => List.unmodifiable(_locations);

  List<Location> get availableLocations {
    return _locations.where((loc) => !loc.isBlocked).toList();
  }

  List<Location> get blockedLocations {
    return _locations.where((loc) => loc.isBlocked).toList();
  }

  void addLocation(Location location) {
    _locations.add(location);
    notifyListeners();
  }

  void updateLocation(Location location) {
    final index = _locations.indexWhere((loc) => loc.id == location.id);
    if (index >= 0) {
      _locations[index] = location;
      notifyListeners();
    }
  }

  void deleteLocation(String locationId) {
    _locations.removeWhere((loc) => loc.id == locationId);
    notifyListeners();
  }

  void toggleLocationBlock(String locationId) {
    final index = _locations.indexWhere((loc) => loc.id == locationId);
    if (index >= 0) {
      _locations[index] = _locations[index].copyWith(
        isBlocked: !_locations[index].isBlocked,
      );
      notifyListeners();
    }
  }

  void blockLocation(String locationId) {
    final index = _locations.indexWhere((loc) => loc.id == locationId);
    if (index >= 0) {
      _locations[index] = _locations[index].copyWith(isBlocked: true);
      notifyListeners();
    }
  }

  void unblockLocation(String locationId) {
    final index = _locations.indexWhere((loc) => loc.id == locationId);
    if (index >= 0) {
      _locations[index] = _locations[index].copyWith(isBlocked: false);
      notifyListeners();
    }
  }

  Location? getLocationById(String id) {
    try {
      return _locations.firstWhere((loc) => loc.id == id);
    } catch (e) {
      return null;
    }
  }
}