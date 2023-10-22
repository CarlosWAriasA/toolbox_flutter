import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tarea_seis/views/about.dart';
import 'package:tarea_seis/views/guessAge.dart';
import 'package:tarea_seis/views/guessGenre.dart';
import 'package:tarea_seis/views/page.dart';
import 'package:tarea_seis/views/universities.dart';
import 'package:tarea_seis/views/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> customButtons = [
    {
      "name": "Guess Genre",
      "icon": FontAwesomeIcons.venusMars,
      "route": "GuessGenre"
    },
    {"name": "Guess age", "icon": FontAwesomeIcons.wandMagicSparkles,"route" : "GuessAge"},
    {
      "name": "Universities per country",
      "icon": FontAwesomeIcons.buildingColumns,
      "route": "Universities"
    },
    {"name": "Weather", "icon": FontAwesomeIcons.cloudSunRain, "route": "Weather"},
    {"name": "Wordpress Page", "icon": FontAwesomeIcons.newspaper, "route": "Page"},
    {"name": "About", "icon": FontAwesomeIcons.addressCard, "route": "About"},
  ];

  void handleButtonPress(String routeName) {
    switch (routeName) {
      case "GuessGenre":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const GuessGenre()));
        break;

      case "GuessAge":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const GuessAge()));
        break;

      case "Universities":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Universities()));
        break;

      case "Weather":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Weather(context: context,)));
        break;

      case "Page":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const WPage()));
        break;

      case "About":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const About()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Image.asset(
              "assets/images/toolbox.png",
              height: 200,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: customButtons.length,
            itemBuilder: (context, index) {
              final button = customButtons[index];
              return Column(children: [
                const SizedBox(
                  height: 20,
                ),
                FilledButton.tonal(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(20)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed: () {
                    handleButtonPress(button["route"]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        button["icon"],
                        size: 30,
                        color: Colors.cyan,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        button["name"],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ]);
            },
          ),
        ),
      ]),
    );
  }
}
