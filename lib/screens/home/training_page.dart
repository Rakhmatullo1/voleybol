import 'package:appnew/helper/db_helper.dart';
import 'package:appnew/screens/home/training_info_page.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrainingListScreen extends StatefulWidget {
  static String routeName = "/training";
  const TrainingListScreen({super.key});
  @override
  State<TrainingListScreen> createState() => _TrainingListScreenState();
}

List<String> months = [
  'Sentabr',
  'Oktabr',
  'Noyabr',
  'Dekabr',
  'Yanvar',
  'Fevral',
  'Mart',
  'Aprel',
  'May',
  'Iyun',
  'Iyul',
  'Avgust',
];

class _TrainingListScreenState extends State<TrainingListScreen> {
  Stream<QuerySnapshot> _getTrainingsStream() {
    return FirebaseFirestore.instance.collection('trainings').snapshots();
  }

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: accentColor),
        title: const Text("Mening Mashg'ulotlarim",
            style: TextStyle(color: accentColor, fontWeight: FontWeight.w500)),
        backgroundColor: backGroungColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getTrainingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: accentColor,
            ));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No months found.'));
          }
          var data = snapshot.data!.docs[0].data() as Map<String, dynamic>;
          List<String> sortedKeys = [];
          for(int i=0; i<months.length; i++) {
            for(int j=0; j<data.keys.length; j++) {
              if(months[i] == data.keys.elementAt(j)) {
                sortedKeys.add(months[i]);
              }
            }
          }


          return FutureBuilder(
            future: dbHelper.query(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: accentColor,
                );
              }
              final dbData = snapshot.data;
              int openMonth = dbData!['open_month'];
              return ListView.builder(
                itemCount: sortedKeys.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: index < openMonth
                        ? () => Navigator.of(context).pushNamed(
                                TrainingInfoScreen.route,
                                arguments: {
                                  "value": data[sortedKeys[index]],
                                  "key": sortedKeys[index],
                                  "openLecture": index == openMonth - 1
                                      ? dbData["open_lecture"]
                                      : null,
                                  "monthIndex": index + 1
                                })
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
                          gradient: const LinearGradient(
                            colors: [accentColor, Colors.white],
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sortedKeys[index],
                              style: const TextStyle(
                                fontSize: 24,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (openMonth > index) ...{
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              ),
                            } else ...{
                              const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            }
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
