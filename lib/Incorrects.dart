/*
 * edit: 2024-09-14
 * 딩카 오답노트 화면
 */


import 'dart:math';
import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/data.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/problem_body.dart';
import 'package:coding_cow_app/widgets/problem_bottom_menu.dart';
import 'package:flutter/services.dart';

class Incorrects_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    hint = false;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (context) => Main_Page()
            ),(route) => false
        );
      },
      child: MaterialApp( // root widget
        theme: ThemeData( // font setting (나눔고딕코딩)
          fontFamily: 'NanumCoding',
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: FutureBuilder(
            future: incorrectsFromFirestore(auth.currentUser?.email),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              // problem_no = Random().nextInt(get_problems.length); // 문제 랜덤 선정
              if (snapshot.hasData) { // 데이터가 전부 로드되었을 때
                return SafeArea( // 앱이 상태창 아래부터 표시되도록 함
                  bottom: false,
                  child: Column(
                    children: [
                      TopBar(),
                      // Text(
                      //   "현재 계정: ${auth.currentUser?.email}",
                      // ),
                      Problem_Title(),
                      // Problem_notice와 동일하게
                    ],
                  ),
                );
              }

              return Center( // 데이터가 로드되지 않았을 때
                child: Text(
                  "오답 문제 로딩중",
                  textAlign: TextAlign.center,
                ),
              );
              // end of middle
            },
          ),
        ),
      ),
    );
  }
}