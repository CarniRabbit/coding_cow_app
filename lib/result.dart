/*
 * 2024-05-07
 * 딩카 결과화면
 */


import 'package:flutter/material.dart';
import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/result_body.dart';
import 'package:coding_cow_app/widgets/result_bottom_menu.dart';
import 'package:flutter/services.dart';

class Result_Page extends StatelessWidget {
  final int status;
  Result_Page(this.status);
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

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
          body: SafeArea( // 앱이 상태창 아래부터 표시되도록 함
            bottom: false,
            child: Column(
              children: [
                TopBar(),
                Problem_Title(),
                Result_Body(this.status),
                Result_Bottom_Menu(),
              ],
            ),
          ), // end of middle
        ),
      ),
    );
  }
}