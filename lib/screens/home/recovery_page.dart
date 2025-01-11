import 'package:appnew/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecoveryScreen extends StatefulWidget {
  static String route = "/recovery";

  const RecoveryScreen({super.key});
  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  Stream<QuerySnapshot> _getTrainingsStream() {
    return FirebaseFirestore.instance.collection('recovery').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroungColor,
        iconTheme: const IconThemeData(color: accentColor),
        title: const Text(
          'Qayta tiklanish',
          style: TextStyle(
              color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      backgroundColor: backGroungColor,
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
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['header'],
                      style: const TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      data['info'],
                      style: const TextStyle(color: secondaryColor),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
