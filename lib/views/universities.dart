import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tarea_seis/utils/request.helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/University.dart';

class Universities extends StatefulWidget {
  const Universities({super.key});

  @override
  _UniversitiesState createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  TextEditingController textController = TextEditingController();
  List<University>? universities;
  bool showText = false;

  void getUniversities() async {
    try {
      final name = textController.text.trim();
      final httpUtil = HttpUtil(baseUrl: "http://universities.hipolabs.com");
      final response = await httpUtil.get("search?country=$name");
      List<University> data = (response as List<dynamic>).map((universityJson) {
        return University.fromJson(universityJson);
      }).toList();
      setState(() {
        showText = true;
        universities = data;
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
          'Universities',
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
                hintText: 'Enter the country name',
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextButton(
                onPressed: getUniversities,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                child: const Text(
                  "Show universities",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )),
          Visibility(
            visible: showText,
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: universities?.map((u) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              u.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("Dominio: ${u.domains[0]}"),
                            GestureDetector(
                              onTap: () async {
                                final url = Uri(scheme: "https", host: u.domains[0]);
                                if (!await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw "Can not launch url";
                                }
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Pagina Web: ",
                                  style: const TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: u.webPages[0],
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList() ??
                      [],
                )),
          )
        ],
      ),
    );
  }
}
