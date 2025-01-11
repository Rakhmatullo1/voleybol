import 'package:appnew/screens/home/training_extra_info.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TrainingInfoScreen extends StatefulWidget {
  static String route = "/training-info";
  const TrainingInfoScreen({super.key});
  @override
  State<TrainingInfoScreen> createState() => _TrainingInfoScreenState();
}

class _TrainingInfoScreenState extends State<TrainingInfoScreen> {
  List<dynamic> data = [{}];
  String name = "";
  int? openLecture;
  int monthIndex = 1;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> parameter =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    data = jsonDecode(parameter["value"]!);
    name = parameter["key"]!;
    openLecture = parameter["openLecture"];
    openLecture = parameter["openLecture"] ?? data.length;
    monthIndex = parameter["monthIndex"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: accentColor),
        backgroundColor: backGroungColor,
        title: Text(name,
            style: const TextStyle(
                color: accentColor, fontWeight: FontWeight.bold, fontSize: 30)),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            Map partialData = (data[index] as Map);
            return InkWell(
              onTap: index < openLecture!
                  ? () {
                      Navigator.of(context)
                          .pushNamed(TrainingExtraInfoScreen.route, arguments: {
                        "data": partialData,
                        "isLastLecture": data.length - 1 == index,
                        "monthIndex": monthIndex,
                        "lectureIndex": index + 1
                      });
                    }
                  : null,
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        partialData["key"],
                        style: const TextStyle(
                          fontSize: 24,
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (openLecture! <= index)
                        const Icon(
                          Icons.lock,
                          color: accentColor,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
