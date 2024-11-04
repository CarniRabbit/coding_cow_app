import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'data_account.dart';

class RankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: getRankingData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  children: [
                    TopBar(),
                    Main_Navigator(),
                    Main_Adress_Input(),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            RankingContent(snapshot.data),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: Text(
                "랭킹 데이터 로딩중",
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}

class RankingContent extends StatelessWidget {
  final List<dynamic> rankingData;

  RankingContent(this.rankingData);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: rankingData.length,
        itemBuilder: (context, index) {
          final user = rankingData[index];
          return ListTile(
            leading: Text((index + 1).toString()), // 순위 표시
            title: Text(user['uid']),
            trailing: Text("점수: ${user['totalScore']}"),
          );
        },
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> getRankingData() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('userStats')
        .orderBy('totalScore', descending: true)
        .limit(10) // 상위 10명의 사용자만 가져옴
        .get();

    List<Map<String, dynamic>> rankingData = snapshot.docs.map((doc) {
      return {
        'uid': doc['uid'],
        'totalScore': doc['totalScore']
      };
    }).toList();

    return rankingData;
  } catch (e) {
    print("랭킹 데이터를 가져오는 중 오류가 발생했습니다: $e");
    return [];
  }
}