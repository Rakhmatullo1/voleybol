import 'dart:convert';

import 'package:appnew/screens/home/competition_info_page.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CompetitionScreen extends StatefulWidget {
  static String route = "/competitions";

  const CompetitionScreen({super.key});
  @override
  State<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
  Stream<QuerySnapshot> _getTrainingsStream() {
    return FirebaseFirestore.instance.collection('competitions').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroungColor,
        iconTheme: const IconThemeData(color: accentColor),
        title: const Text(
          'Musobaqalar',
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
            List<Meeting> apps = data.values.map((val) {
              var decodedData = jsonDecode(val);
              DateTime from = DateTime.parse(decodedData["date"]);
              return Meeting(decodedData["name"], from, from, Colors.red, true,
                  decodedData);
            }).toList();
            return SfCalendar(
              view: CalendarView.month,
              firstDayOfWeek: 1,
              todayHighlightColor: accentColor,
              selectionDecoration:
                  BoxDecoration(border: Border.all(color: secondaryColor)),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              appointmentBuilder: (context, details) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                );
              },
              dataSource: MeetingDataSource(apps),
              initialSelectedDate: DateTime.now(),
              viewHeaderStyle: const ViewHeaderStyle(
                  dateTextStyle: TextStyle(color: Colors.white)),
              headerStyle: const CalendarHeaderStyle(
                  backgroundColor: secondaryColor,
                  textStyle: TextStyle(color: Colors.white)),
              onSelectionChanged: (CalendarSelectionDetails details) {
                for (Meeting m in apps) {
                  if (m.from == details.date) {
                    Navigator.of(context).pushNamed(CompetitionInfoScreen.route,
                        arguments: m.decodedData);
                  }
                }
              },
            );
          }),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.decodedData);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  dynamic decodedData;
}
