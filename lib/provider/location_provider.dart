import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  String? _errorMessage;
  Placemark? _placemark;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Getter for placemark
  Placemark? get placemark => _placemark;

  // Method to get the placemark based on current location
  Future<Placemark?> getPlacemark() async {
    try {
      // Get the current position
      Position position = await _determinePosition();

      // Get the placemarks from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude
      );


      if (placemarks.isNotEmpty) {
        // Update the placemark and clear any error
        _placemark = placemarks.first;
        // _log.w(_placemark);
        _errorMessage = null;
      } else {
        _errorMessage = 'No placemarks found';
        _placemark = null;
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      _placemark = null;
    }

    notifyListeners();
    return _placemark;
  }

  // Method to set the placemark directly
  void setPlacemark(Placemark placemark) {
    _placemark = placemark;
    _errorMessage = null;
    notifyListeners();
  }

  // Method to determine the current position
  Future<Position> _determinePosition() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    // Check for location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    // Set location settings
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    // Get the current position with settings
    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings
    );
  }
}
