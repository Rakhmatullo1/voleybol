import 'package:appnew/screens/home_screen.dart';
import 'package:appnew/screens/static.dart';
import 'package:flutter/material.dart';

class RecoveryScreen extends StatefulWidget {
  static String route = "/recovery";

  const RecoveryScreen({super.key});
  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backGroungColor,
          iconTheme: const IconThemeData(color: accentColor),
          title: const Text(
            'Qayta tiklanish',
            style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
        backgroundColor: backGroungColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(
                    'Malakali voleybolchi qizlarning qayta tiklanish jarayoni'),
                getParagraphStyle(p1),
                getParagraphStyle(p2),
                getParagraphStyle(p3),
                getFrame("r5"),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: const Alignment(0, 0),
                  child: getHeader("Jismoniy tiklanish vositalari"),
                ),
                getParagraphStyle(p4),
                getParagraphStyle(p5),
                getFrame("r4"),
                getParagraphStyle(p7),
                getParagraphStyle(p8),
                getHeader(p9),
                getParagraphStyle(p10),
                getFrame("r3"),
                getParagraphStyle(p11),
                getParagraphStyle(p12),
                getFrame("r2"),
                getHeader(
                    "Sportchi organizmini tiklashning zamonaviy usullari."),
                getParagraphStyle(p13),
                getFrame("r1")
              ],
            ),
          ),
        ));
  }

  Text getHeader(String text) {
    return Text(
      '\n$text\n',
      style: const TextStyle(
        color: secondaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),
      textAlign: TextAlign.center,
    );
  }

  RichText getParagraphStyle(String text) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          const WidgetSpan(child: SizedBox(width: 35)),
          TextSpan(text: text),
        ],
        style: const TextStyle(
            color: secondaryColor, fontFamily: 'Montserrat', fontSize: 16),
      ),
    );
  }

  Padding getFrame(String fileName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Image.asset("assets/images/$fileName.jpeg"),
    );
  }
}
