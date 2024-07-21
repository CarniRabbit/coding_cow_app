/*
 * edit: 2024-04-14
 * 딩카 문제 화면
 */


import 'dart:math';
import 'package:coding_cow_app/data.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/problem_body.dart';
import 'package:coding_cow_app/widgets/problem_bottom_menu.dart';
import 'package:flutter/services.dart';

class Problem_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    hint = false;

    return MaterialApp( // root widget
      theme: ThemeData( // font setting (나눔고딕코딩)
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: fromFirestore("Problems"),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print(snapshot.data[0]);
            return SafeArea( // 앱이 상태창 아래부터 표시되도록 함
              bottom: false,
              child: Column(
                children: [
                  TopBar(),
                  Problem_Title(),
                  Problem_Body(),
                  Problem_Bottom_Menu(),
                ],
              ),
            ); // end of middle
          },
        ),
      ),
    );
  }
}