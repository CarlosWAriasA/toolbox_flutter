import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('About'),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Image.asset("assets/images/my-image.jpg"),
            const Text(
              "Carlos Arias",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text("carlos.ariasalmanzar@gmail.com", style: TextStyle(fontSize: 14),),
            Text("Matricula: 2022-0021", style: TextStyle(fontSize: 14))
          ],
        )),
      ),
    );
  }
}
