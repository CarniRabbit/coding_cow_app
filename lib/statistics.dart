/*
통계 페이지
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/statistics_resultDistribution.dart';
import 'package:coding_cow_app/widgets/statistics_weeklyProblems.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data_account.dart';

Future<UserStats?> fetchUserStats(String uid) async {
  // 사용자 통계 가져오기
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection('UserStats').doc(uid).get();

  if (snapshot.exists) {
    return UserStats.fromJson(snapshot.data()!);
  }
  return UserStats(
    uid: uid,
    lastUpdated: Timestamp.now(),
  );
}

class StatPage extends StatefulWidget {
  final String uid;

  StatPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StatPageState();
}

class StatPageState extends State<StatPage> {
  late Future<UserStats?> _userStatsFuture;

  @override
  void initState() {
    super.initState();
    _userStatsFuture = fetchUserStats(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nanumcoding',
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TopBar(),
              Main_Navigator(),
              Main_Adress_Input(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<UserStats?>(
                    future: _userStatsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Center(child: Text('No data'));
                      } else {
                        UserStats userStats = snapshot.data!;

                        return ListView(
                          children: [
                            GridView.count(
                              crossAxisCount: 1,
                              // 두 개의 열로 카드 배치
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              // GridView가 ListView에 맞춰 크기 조정
                              physics: NeverScrollableScrollPhysics(),
                              // 스크롤 방지
                              children: [
                                DashboardCard(
                                  title: 'Total Problems',
                                  value:
                                      userStats.totalProblemsSolved.toString(),
                                ),
                                DashboardCard(
                                  title: 'Total Score',
                                  value: userStats.totalScore.toString(),
                                ),
                                Card(
                                  elevation: 2,
                                  child: Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'Weekly Accomplishment',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: WeeklyProblemsChart(uid: widget.uid),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  child: Container(
                                    height: 200, // 카드의 고정된 높이 설정
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'Problem Distribution',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: StatisticsChart(
                                              userStats: userStats),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  DashboardCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
