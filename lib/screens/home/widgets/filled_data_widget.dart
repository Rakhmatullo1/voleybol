import 'package:appnew/helper/db_helper.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FilledDataWidget extends StatelessWidget {
  final Map<String, dynamic>? data;
  final DatabaseHelper dbHelper = DatabaseHelper();
  FilledDataWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Expanded(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/profile.webp'), // Replace with your image asset
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    alignment: const Alignment(0, 0),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      data == null
                          ? "Guest"
                          : data!["first_name"]! + " " + data!["last_name"]!,
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 18),
                      softWrap: true,
                    ),
                  ),
                ),
                Expanded(
                    child: InfoCardWidget(
                  value: "Yosh",
                  keyOfValue: "${data!["age"]}",
                )),
                Expanded(
                    child: InfoCardWidget(
                  value: "Vazn",
                  keyOfValue: "${data!["weight"]} (kg)",
                )),
                Expanded(
                    child: InfoCardWidget(
                  value: "Bo'y",
                  keyOfValue: "${data!["height"]} (cm)",
                ))
              ],
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10)),
                  onPressed: () async {
                    await dbHelper.deleteAll();
                    await dbHelper.insertUser(
                        data!["first_name"], data!["last_name"]);
                    Navigator.of(context).pushNamed(HomeScreen.route);
                  },
                  child: const Text(
                    "Tozalash",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ))
      ],
    );
  }
}

class InfoCardWidget extends StatelessWidget {
  final String value;
  final String keyOfValue;

  const InfoCardWidget(
      {super.key, required this.value, required this.keyOfValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(value, secondaryColor.withOpacity(0.7)),
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: text(keyOfValue, accentColor)),
          ],
        ),
        const Divider(
          color: secondaryColor,
        )
      ],
    );
  }

  Widget text(String name, Color color) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 24,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
