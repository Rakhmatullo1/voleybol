import 'package:appnew/screens/home/pdf_viewer.dart';
import 'package:appnew/screens/home/video_screen.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class TrainingInfoPartOneScreen extends StatefulWidget {
  static String route = "/training-info-part-one";

  const TrainingInfoPartOneScreen({super.key});
  @override
  State<TrainingInfoPartOneScreen> createState() =>
      _TrainingInfoPartOneScreenState();
}

class _TrainingInfoPartOneScreenState extends State<TrainingInfoPartOneScreen> {
  Map data = {};
  bool isOnePlayed = false;
  bool isGameNull = true;
  bool isMoreOne = false;
  bool isMoreTwo = false;
  bool isMoreThree = false;
  List<String> headings = ["Mashg‘ulot kunlari", "Me’yori", "Metodik tavsiya"];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as Map;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        backgroundColor: backGroungColor,
        iconTheme: const IconThemeData(color: accentColor),
        title: const Text(
          "Asosiy qism",
          style: TextStyle(
              color: accentColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        isMoreOne = !isMoreOne;
                      });
                    },
                    child: dropDown4Item(data["item1"]["key"], isMoreOne)),
                if (isMoreOne) ...{drowDownItems(width, data["item1"])},
                InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => {
                          setState(() {
                            isMoreTwo = !isMoreTwo;
                          })
                        },
                    child: dropDown4Item(data["item2"]["key"], isMoreTwo)),
                if (isMoreTwo) ...{drowDownItems(width, data["item2"])},
                InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        isMoreThree = !isMoreThree;
                      });
                    },
                    child: dropDown4Item(data["item3"]["key"], isMoreThree)),
                if (isMoreThree) ...{
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(VideosScreenMore.route,
                            arguments: data["item3"]["video"]);
                      },
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(200, 65),
                        backgroundColor: Colors.white, // Background color
                        side: const BorderSide(
                            color: accentColor), // Border color
                      ),
                      child: const Text(
                        'Videolar',
                        style: TextStyle(
                            color: accentColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                }
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drowDownItems(double width, Map<String, dynamic> partialData) {
    List<dynamic> dataTables = partialData["table"] as List;
    return SizedBox(
      width: width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accentColor, width: 2),
                    ),
                    child: DataTable(
                      dataRowMinHeight: 20,
                      dataRowMaxHeight: 100,
                      border: TableBorder.all(),
                      columns: headings
                          .map((value) => DataColumn(
                              label: SizedBox(
                                  child: Text(value,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      softWrap: true))))
                          .toList(),
                      rows: dataTables.map((value) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  value["key"],
                                  softWrap: true,
                                ),
                              ),
                            ),
                            DataCell(SizedBox(
                                width: 80,
                                child:
                                    Text(value["duration"], softWrap: true))),
                            DataCell(
                              SizedBox(
                                width: 200,
                                child: Text(
                                  value["suggestion"],
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(VideosScreenMore.route,
                    arguments: partialData["video"]);
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(200, 65),
                backgroundColor: Colors.white, // Background color
                side: const BorderSide(color: accentColor), // Border color
              ),
              child: const Text(
                'Videolar',
                style:
                    TextStyle(color: accentColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PDFViewerScreen.route,
                    arguments: partialData["description"]);
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(200, 65),
                backgroundColor: Colors.white, // Background color
                side: const BorderSide(color: accentColor), // Border color
              ),
              child: const Text(
                'Mashg\'ulot tavsifi',
                style:
                    TextStyle(color: accentColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container dropDown4Item(String text, bool isMore) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 70,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.green, offset: Offset(0, 10), blurRadius: 10)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: accentColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(
            isMore ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: accentColor,
          )
        ],
      ),
    );
  }
}
