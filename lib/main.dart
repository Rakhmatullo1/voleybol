import 'package:appnew/helper/db_helper.dart';
import 'package:appnew/screens/home/competition_info_page.dart';
import 'package:appnew/screens/home/competition_page.dart';
import 'package:appnew/screens/home/menstrual.dart';
import 'package:appnew/screens/home/pdf_viewer.dart';
import 'package:appnew/screens/home/recovery_page.dart';
import 'package:appnew/screens/home/theory_page.dart';
import 'package:appnew/screens/home/training_extra_info.dart';
import 'package:appnew/screens/home/training_info_page.dart';
import 'package:appnew/screens/home/training_info_part.dart';
import 'package:appnew/screens/home/training_info_part_one.dart';
import 'package:appnew/screens/home/training_page.dart';
import 'package:appnew/screens/home/user_info.dart';
import 'package:appnew/screens/home/video_screen.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:appnew/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('uz'),
      ],
      locale: const Locale('uz'),
      title: 'Voleybol',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: secondaryColor,
      ),
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
        InfoCardScreen.rountName: (_) => const InfoCardScreen(),
        PDFViewerScreen.route: (_) => const PDFScreen(),
        UserInfoForm.route: (_) => const UserInfoForm(),
        TrainingListScreen.routeName: (_) => const TrainingListScreen(),
        TrainingInfoScreen.route: (_) => const TrainingInfoScreen(),
        TrainingExtraInfoScreen.route: (_) => const TrainingExtraInfoScreen(),
        TrainingInfoPartScreen.route: (_) => const TrainingInfoPartScreen(),
        TrainingInfoPartOneScreen.route: (_) =>
            const TrainingInfoPartOneScreen(),
        CompetitionScreen.route: (_) => const CompetitionScreen(),
        CompetitionInfoScreen.route: (_) => const CompetitionInfoScreen(),
        RecoveryScreen.route: (_) => const RecoveryScreen(),
        MenstrualSiklScreen.rountName: (_) => const MenstrualSiklScreen(),
        VideosScreenMore.route: (_) => const VideosScreenMore(),
        VideoPlayerScreen.route: (_) => const VideoPlayerScreen()
      },
      home: FutureBuilder(
        future: _dbHelper.existsUser(),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: accentColor,
              ),
            );
          }
          _dbHelper.getUserDetails();
          if (result.hasData) {
            bool? result1 = result.data;
            if (result1 == null || result1) {
              return const LoginPage();
            }
            return const HomeScreen();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
