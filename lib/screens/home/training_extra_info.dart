import 'package:appnew/screens/home/training_info_part.dart';
import 'package:appnew/screens/home/training_info_part_one.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class TrainingExtraInfoScreen extends StatefulWidget {
  static String route = "/training-extra-info";

  const TrainingExtraInfoScreen({super.key});

  @override
  State<TrainingExtraInfoScreen> createState() =>
      _TrainingExtraInfoScreenState();
}

class _TrainingExtraInfoScreenState extends State<TrainingExtraInfoScreen> {
  Map data = {};
  bool isLastLecture = false;
  int lectureIndex = 0;
  int monthIndex = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final parameter = ModalRoute.of(context)!.settings.arguments as Map;
    data = parameter['data'] as Map;
    isLastLecture = parameter["isLastLecture"] as bool;
    lectureIndex = parameter["lectureIndex"];
    monthIndex = parameter["monthIndex"];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: backGroungColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomeScreen.route);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          iconTheme: const IconThemeData(color: accentColor),
          title: Text(data["key"],
              style: const TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: backGroungColor,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(50),
                        bottomEnd: Radius.circular(50)),
                    child: Image.asset("assets/images/training.png")),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(TrainingInfoPartScreen.route, arguments: {
                    "name": "Kirish qismi",
                    "value": data["value"]["entrance"],
                    "isFinalPart": false,
                    "isLastLecture": isLastLecture,
                    "monthIndex": monthIndex,
                    "lectureIndex": lectureIndex
                  });
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(200, 65),
                  backgroundColor: Colors.white, // Background color
                  side: const BorderSide(color: accentColor), // Border color
                ),
                child: const Text(
                  'Kirish qismi',
                  style:
                      TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(TrainingInfoPartOneScreen.route,
                      arguments: {
                        "name": "Asosiy qism",
                        "value": data["value"]["main"]
                      });
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(200, 65),
                  backgroundColor: Colors.white, // Background color
                  side: const BorderSide(color: accentColor), // Border color
                ),
                child: const Text(
                  'Asosiy qism',
                  style:
                      TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(TrainingInfoPartScreen.route, arguments: {
                    "name": "Yakuniy qism",
                    "value": data["value"]["final"],
                    "isLastLecture": isLastLecture,
                    "isFinalPart": true,
                    "monthIndex": monthIndex,
                    "lectureIndex": lectureIndex
                  });
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(200, 65),
                  backgroundColor: Colors.white, // Background color
                  side: const BorderSide(color: accentColor), // Border color
                ),
                child: const Text(
                  'Yakuniy qism',
                  style:
                      TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
