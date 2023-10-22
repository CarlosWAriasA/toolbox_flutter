import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tarea_seis/model/Post.dart';
import 'package:tarea_seis/utils/request.helper.dart';
import 'package:url_launcher/url_launcher.dart';

class WPage extends StatefulWidget {
  const WPage({super.key});

  @override
  _WPageState createState() => _WPageState();
}

class _WPageState extends State<WPage> {
  TextEditingController textController = TextEditingController();
  int result = 0;
  bool showText = false;
  List<Post>? posts;

  void getPages() async {
    try {
      final httpUtil = HttpUtil(baseUrl: "https://time.com/wp-json/wp/v2");
      final response = await httpUtil.get("posts?per_page=3");
      List<Post> data = (response as List<dynamic>).map((postJson) {
        return Post.fromJson(postJson);
      }).toList();
      setState(() {
        showText = true;
        posts = data;
      });
    } catch (e) {
      print("Error on the http request: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Wordpress Page',
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
          Image.asset("assets/images/time.png"),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: showText,
            child: Column(
              children: posts?.map((p) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          p.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url = Uri.parse(p.link);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              throw "Could not launch the URL";
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              p.link,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                        Text("${p.description.substring(0, 450)}...")
                      ],
                    );
                  }).toList() ??
                  [],
            ),
          )
        ],
      ),
    );
  }
}
