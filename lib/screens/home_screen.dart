import 'package:appnew/screens/home/competition_page.dart';
import 'package:appnew/screens/home/pdf_viewer.dart';
import 'package:appnew/screens/home/recovery_page.dart';
import 'package:appnew/screens/home/theory_page.dart';
import 'package:appnew/screens/home/training_page.dart';
import 'package:appnew/screens/home/user_info.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const Color backGroungColor = Color.fromRGBO(244, 231, 211, 1);
const Color primaryColor = Color.fromRGBO(0, 123, 255, 1);
const Color secondaryColor = Color.fromRGBO(255, 127, 80, 1);
const Color accentColor = Color.fromRGBO(255, 127, 80, 1);

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'UV-Training',
              style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            backgroundColor: backGroungColor,
            elevation: 0,
          ),
          body: Container(
            color: backGroungColor,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(UserInfoForm.route),
                          child: const MenuCard(
                            title: 'Mening ma\'lumotlarim',
                            imageName: "assets/images/volleyball1.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(InfoCardScreen.rountName),
                          child: const MenuCard(
                            title: 'Nazariy ma\'lumotlar',
                            imageName: "assets/images/volleyball2.jpg",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed(TrainingListScreen.routeName),
                    child: const MenuCard(
                      title: 'Mening mashg\'ulotlarim',
                      imageName: "assets/images/valleyball4.jpeg",
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).pushNamed(PDFViewerScreen.route,
                          arguments: "menstrual_sikl")
                    },
                    child: const MenuCard(
                      title: 'Menstrual sikl',
                      imageName: "assets/images/volleyball3.jpeg",
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(CompetitionScreen.route);
                        },
                        child: const MenuCard(
                          title: 'Musobaqalar',
                          imageName: "assets/images/cup.webp",
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(RecoveryScreen.route),
                        child: const MenuCard(
                            title: 'Qayta tiklanish',
                            imageName: "assets/images/volleyball5.webp"),
                      ),
                    )
                  ],
                ))
              ],
            ),
          )),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String imageName;

  const MenuCard({super.key, required this.title, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageName), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
