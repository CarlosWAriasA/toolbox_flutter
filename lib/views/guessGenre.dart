import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tarea_seis/utils/request.helper.dart';

class GuessGenre extends StatefulWidget {
  const GuessGenre({super.key});

  @override
  _GuessGenreState createState() => _GuessGenreState();
}

class _GuessGenreState extends State<GuessGenre> {
  TextEditingController textController = TextEditingController();
  String result = "";
  bool showText = false;

  void getGenre() async {
    try {
      final name = textController.text.trim();
      final httpUtil = HttpUtil(baseUrl: "https://api.genderize.io/");
      final response = await httpUtil.get("?name=$name");
      setState(() {
        showText = true;
        result = response["gender"] ?? "";
      });
    } catch (e) {
      print("Error on the http request: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Guess Genre',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 20, right: 20, top: 20),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.black, width: 2.0, style: BorderStyle.solid)),
                hintText: 'Enter the name',

              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextButton(
                onPressed: getGenre,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                child: const Text(
                  "Guess",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )),
          Visibility(
            visible: showText,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FaIcon(
                  result == "male"
                      ? FontAwesomeIcons.mars
                      : result == "female"
                          ? FontAwesomeIcons.venus
                          : FontAwesomeIcons.rotateLeft,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  result != "" ? "You're a $result" : "Not defined",
                  style: TextStyle(
                    fontSize: 24,
                    color: result == "male"
                        ? Colors.blue
                        : result == "female"
                            ? Colors.pink.shade400
                            : Colors.brown,
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
