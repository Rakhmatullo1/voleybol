import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CompetitionInfoScreen extends StatefulWidget {
  static String route = "/competitions-info";

  const CompetitionInfoScreen({super.key});
  @override
  State<CompetitionInfoScreen> createState() => _CompetitionInfoScreenState();
}

class _CompetitionInfoScreenState extends State<CompetitionInfoScreen> {
  Map<dynamic, dynamic> data = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as Map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backGroungColor,
          iconTheme: const IconThemeData(color: accentColor),
          title: Text(
            data['name'],
            style: const TextStyle(
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
                Text(
                  data['date'],
                  style: const TextStyle(color: Colors.black26),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data['value'],
                  style: const TextStyle(color: secondaryColor),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ));
  }
}
