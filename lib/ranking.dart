import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/ranking_rankbox.dart';

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
                    SizedBox(height: 20),
                    CurrentUserRankBox(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  "RANKING"),
                              SizedBox(height: 10),
                              RankingContent(snapshot.data),
                            ],
                          ),
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
  final List<Map<String, dynamic>> rankingData;

  RankingContent(this.rankingData);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: rankingData.length,
          itemBuilder: (context, index) {
            final user = rankingData[index];
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  tileColor: Colors.white,
                  selectedTileColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    user['nickname'] ?? '닉네임 없음',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    "문제 해결 수: ${user['problemsSolved']}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

Future<List<Map<String, dynamic>>> getRankingData() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .orderBy('problemsSolved', descending: true)
        .limit(10) // 상위 10명의 사용자만 가져옴
        .get();

    List<Map<String, dynamic>> rankingData = snapshot.docs.map((doc) {
      return {
        'nickname': doc['nickname'] ?? '닉네임 없음',
        // nickname이 없는 경우 기본값 설정
        'problemsSolved': doc['problemsSolved'] ?? 0,
        // problemsSolved가 없는 경우 기본값 0 설정
      };
    }).toList();

    return rankingData;
  } catch (e) {
    print("랭킹 데이터를 가져오는 중 오류가 발생했습니다: $e");
    return [];
  }
}