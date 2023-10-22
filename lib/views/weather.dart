import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tarea_seis/utils/request.helper.dart';

class Weather extends StatefulWidget {
  final BuildContext context;

  Weather({required this.context, Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  double temp = 0;
  bool showTemp = false;
  String desc = "";

  int kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).round();
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context, // Utiliza el contexto de la aplicación
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Permission Denied"),
          content: const Text("Allow access to location"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => openAppSettings(),
              child: const Text("Settings"),
            )
          ],
        );
      },
    );
  }

  Future<Position?> getCurrentTemp() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      final httpUtil =
          HttpUtil(baseUrl: "https://api.openweathermap.org/data/2.5/");
      final response = await httpUtil.get(
          "weather?lat=${position.latitude}&lon=${position.longitude}&appid=aa4c6915571bf2229f2afe8bebd29f0d");

      setState(() {
        showTemp = true;
        temp = (response["main"]["temp"] ?? 0).toDouble();
        desc = response["weather"][0]["description"];
      });
      return position;
    } catch (e) {
      final status = await Permission.location.request();
      if (status.isDenied) {
        _showLocationPermissionDialog();
      }
      print("Error obtaining location: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentTemp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Weather'),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Visibility(
            visible: showTemp,
            child: Column(children: [
              Center(
                  child: Text(
                "${kelvinToCelsius(temp)}°C",
                style: TextStyle(fontSize: 52),
              )),
              Center(
                child: Text(
                  desc,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ])),
      ),
    );
  }
}
