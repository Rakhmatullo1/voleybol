import 'package:appnew/screens/home/pdf_viewer.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

List<Map<String, String>> data = [
  {
    "file_path": "pdf3",
    "name": "Sport va harakatli o'yinlarni o'qitish metodikasi. N.Sh Safarboyev, M.Sh. Saparboyev",
    "image_path": "assets/images/volleyball2.jpg"
  },
  {
    "file_path": "pdf4",
    "name": "Voleybol",
    "image_path": "assets/images/volleyball3.jpeg"
  },
  {
    "file_path": "pdf5",
    "name": "Voleybol nazariyasi va uslubiyati",
    "image_path": "assets/images/volleyball5.webp"
  },
  {
    "file_path": "pdf6",
    "name": "Jismoniy tarbiya va sport (Voleybol)",
    "image_path": "assets/images/valleyball4.jpeg"
  },
  {
    "file_path": "pdf8",
    "name": "Voleybol sport va harakatli o'yinlarni o'qitish metodikasi",
    "image_path": "assets/images/volleyball2.jpg"
  },
  {
    "file_path": "pdf7",
    "name": "Voleybol nazariyasi va uslubiyati (darslik)",
    "image_path": "assets/images/volleyball3.jpeg"
  },
  {
    "file_path": "pdf9",
    "name": "МАССОВЫЙ ВОЛЕЙБОЛ",
    "image_path": "assets/images/volleyball5.webp"
  }

];

class InfoCardScreen extends StatelessWidget {
  static String rountName = "/theory";
  const InfoCardScreen({super.key});

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
          'Nazariy Ma\'lumotlar',
          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: backGroungColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bo'limlar",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index)=>InfoCard(imageUrl: data[index]["image_path"]!, title: data[index]["name"]!, description: 'Batafsil...', onPressed: ()=>{
                  Navigator.of(context).pushNamed(PDFViewerScreen.route, arguments: data[index]["file_path"]!)
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
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const InfoCard({
    super.key,
    required this.imageUrl,
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: accentColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                    ),
                    child: const Icon(Icons.arrow_forward, color: accentColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
