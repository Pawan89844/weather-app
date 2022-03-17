// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/ui/home/weather_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var location;
  String? locality;

  @override
  void initState() {
    super.initState();
    print('location $location');
    setState(() {
      WeatherService.getCurrentLocation(
        location,
        locality == null ? '' : locality!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    var height = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/sunny.jpg'), fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 15.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(locality == null ? 'Loading..' : locality!,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 25.0))),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '19°',
                  style: TextStyle(fontSize: 100.0, color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 80.0,
              child: Card(
                color: Colors.white24,
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeatherData('64%', 'Humidity'),
                    _buildWeatherData('4Km', 'Visibility'),
                    _buildWeatherData('Low 0', 'YIndex'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Padding _buildWeatherData(String percentage, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(percentage, style: const TextStyle(color: Colors.white)),
          const SizedBox(
            height: 8.0,
          ),
          Text(sub, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
