import 'package:flutter/services.dart';

class MapLauncher {
  static const MethodChannel _channel =
      MethodChannel('com.example.travel_guide_app/map_launcher');

  /// Opens Google Maps with coordinates or query
  static Future<bool> openGoogleMaps({
    required double latitude,
    required double longitude,
    required String label,
  }) async {
    // geo: uri or web fallback intent
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&query_place_id=$label';
    try {
      final bool? success =
          await _channel.invokeMethod<bool>('launchMap', {'url': url});
      return success ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Opens Directions in Google Maps
  static Future<bool> openDirections({
    required double latitude,
    required double longitude,
  }) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    try {
      final bool? success =
          await _channel.invokeMethod<bool>('launchMap', {'url': url});
      return success ?? false;
    } catch (_) {
      return false;
    }
  }
}

