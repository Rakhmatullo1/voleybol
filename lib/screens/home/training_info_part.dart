import 'package:appnew/helper/db_helper.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class TrainingInfoPartScreen extends StatefulWidget {
  static String route = "/training-info-part";

  const TrainingInfoPartScreen({super.key});
  @override
  State<TrainingInfoPartScreen> createState() => _TrainingInfoPartScreenState();
}

class _TrainingInfoPartScreenState extends State<TrainingInfoPartScreen> {
  Map data = {};
  final DatabaseHelper dbHelper = DatabaseHelper();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as Map;
    openNextLecture();
  }

  void openNextLecture() async {
    if (data["isFinalPart"]) {
      if (data["isLastLecture"]) {
        await dbHelper.openMonth(data["monthIndex"]);
      } else {
        await dbHelper.openLecture(data["lectureIndex"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade700,
                          offset: const Offset(0, -2),
                          blurRadius: 10)
                    ],
                    borderRadius:
                        const BorderRadius.vertical(bottom: Radius.circular(20))),
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: Image.asset("assets/images/training_one.png")),
              ),
              const SizedBox(height: 20),
              Text(
                data["name"],
                style: const TextStyle(
                    color: accentColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data["value"],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: Colors.black54, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
