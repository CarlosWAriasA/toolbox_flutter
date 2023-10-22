import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tarea_seis/utils/request.helper.dart';

class GuessAge extends StatefulWidget {
  const GuessAge({super.key});

  @override
  _GuessAgeState createState() => _GuessAgeState();
}

class _GuessAgeState extends State<GuessAge> {
  TextEditingController textController = TextEditingController();
  int result = 0;
  bool showText = false;

  void getAge() async {
    try {
      final name = textController.text.trim();
      final httpUtil = HttpUtil(baseUrl: "https://api.agify.io/");
      final response = await httpUtil.get("?name=$name");
      setState(() {
        showText = true;
        final age = response["age"];
        result = age is int ? age : 0;
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
          'Guess Age',
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
            padding:
                const EdgeInsets.only(bottom: 18, left: 20, right: 20, top: 20),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid)),
                hintText: 'Enter the name',
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextButton(
                onPressed: getAge,
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/persona_${result < 27 ? "joven" : result < 61 ? "adulta" : "anciana"}.png",
                      height: 200,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        "Tienes $result años, eres una persona ${result < 27 ? "joven" : result < 61 ? "adulta" : "anciana"}",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
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
