import 'package:appnew/screens/home/pdf_viewer.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

List<Map<String, String>> data = [
  {"file_path": "ortacha", "name": "Menstrual oldi fazasi-o'rta"},
  {"file_path": "12kichik", "name": "Mensturatsiya fazasining 1-2 kuni-kichik"},
  {"file_path": "35kichik", "name": "Mensturatsiya fazasining 3-5 kuni-o'rta"},
  {"file_path": "sezilarli", "name": "Postmenstrual faza-o'rta"},
  {"file_path": "katta", "name": "Ovulyator faza- o'rta"},
  {"file_path": "ortacha", "name": "Postovulyator faza-katta"}
];

class MenstrualSiklScreen extends StatelessWidget {
  static String rountName = "/menstrual";
  const MenstrualSiklScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backGroungColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: accentColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Menstrual sikli fazalari',
          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: backGroungColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => InfoCard(
                    id: index+1 ,
                    title: data[index]["name"]!,
                    description: 'Batafsil...',
                    onPressed: () => {
                          Navigator.of(context).pushNamed(PDFViewerScreen.route,
                              arguments: data[index]["file_path"]!)
                        }),
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final int id;

  const InfoCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Expanded(child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: secondaryColor,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: Text("$id", style: const TextStyle(
                    color: Colors.white
                  ),),
                )),
                Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accentColor),
                  ),
                ),
                const Expanded(child: Icon(Icons.arrow_forward_ios))
              ],
            ),
          ),
        ));
  }
}
