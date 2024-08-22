/*
통계 페이지
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';

Future<UserStats?> fetchUserStats(String uid) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Map<String, dynamic>> snapshot =
  await firestore.collection('UserStats').doc(uid).get();

  if (snapshot.exists) {
    return UserStats.fromJson(snapshot.data()!);
  }
  return null;
}

class Stat_Page extends StatelessWidget {
  final String uid;

  Stat_Page({required this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TopBar(),
              Main_Navigator(),
              Main_Adress_Input(),
              Expanded(
                child: FutureBuilder<UserStats?>(
                  future: fetchUserStats(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No data'));
                    } else {
                      UserStats userStats = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'Solved';
                                    case 1:
                                      return 'Correct';
                                    case 2:
                                      return 'Incorrect';
                                    default:
                                      return '';
                                  }
                                },
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: const Color(0xff37434d),
                                width: 1,
                              ),
                            ),
                            minX: 0,
                            maxX: 2,
                            minY: 0,
                            maxY: userStats.totalProblemsSolved.toDouble(),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, userStats.totalProblemsSolved.toDouble()),
                                  FlSpot(1, userStats.correctProblemsCount.toDouble()),
                                  FlSpot(2, userStats.incorrectProblemsCount.toDouble()),
                                ],
                                isCurved: true,
                                colors: [Colors.blue],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(show: false),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}