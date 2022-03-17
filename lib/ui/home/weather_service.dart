// ignore_for_file: avoid_print
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static bool? serviceEnabled;
  static LocationPermission? permission;

  static _getLocality(double lat, double long, String locality) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

    Placemark getplaceMark = placemark[0];
    locality = getplaceMark.locality!;
    print(locality);
  }

  static Future<Position> getCurrentLocation(
      var currentPosition, String locality) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    Position position = await GeolocatorPlatform.instance.getCurrentPosition();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      permission;
      if (permission == LocationPermission.denied) {
        permission;
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = position;
    _getLocality(position.latitude, position.longitude, locality);
    // print('Lat:- ${position.latitude}');
    // print('Lat:- ${position.longitude}');
    return position;
  }

  static getWeatherInfo() async {
    const String url = '';
    await http.get(Uri.parse(url));
  }
}
