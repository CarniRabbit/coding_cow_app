/*
통계 페이지
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/statistics_chart.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'data.dart';

Future<UserStats?> fetchUserStats(String uid) async {
  //사용자 통계 가져오기
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection('UserStats').doc(uid).get();

  if (snapshot.exists) {
    return UserStats.fromJson(snapshot.data()!);
  }
  return null;
}

class Stat_Page extends StatefulWidget {
  final String uid;
  Stat_Page({Key? key, required this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StatPageState();
}

class StatPageState extends State<Stat_Page> {
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
              SizedBox(height: 20),
              Container(
                child: Text(
                  '나의 실력',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
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
                      return Column(
                        children: [
                          Text(
                            'Total Problems: ${userStats.totalProblemsSolved}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: StatisticsChart(userStats: userStats),
                          ),
                        ],
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
