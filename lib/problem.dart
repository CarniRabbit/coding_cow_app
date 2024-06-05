/*
* 2024-04-14
* 딩카 문제화면1
* 각 위젯마다 시작, 끝 주석으로 표기하기
* 속성에 대한 간략한 설명 주석으로 넣기
* 한글 작성시 항상 자간 -2 (letterSpacing: -2)
* 다음 속성이 없더라도 무조건 반점 찍기
* icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
* */


import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/problem_body.dart';
import 'package:coding_cow_app/widgets/problem_bottom_menu.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Problem_Page());
}

class Problem_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return MaterialApp( // root widget
      theme: ThemeData( // font setting (나눔고딕코딩)
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea( // 앱이 상태창 아래부터 표시되도록 함
          bottom: false,
          child: Column(
            children: [
              TopBar(),
              Problem_Title(),
              Problem_Body(),
              Problem_Bottom_Menu(),
            ],
          ),
        ), // end of middle
      ),
    );
  }
}