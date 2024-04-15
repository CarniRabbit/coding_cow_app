/*
* 2024-04-01
* 딩카 메인화면 하드코딩 (추후 분리 예정)
* 각 위젯마다 시작, 끝 주석으로 표기하기
* 속성에 대한 간략한 설명 주석으로 넣기
* 한글 작성시 항상 자간 -2 (letterSpacing: -2)
* 다음 속성이 없더라도 무조건 반점 찍기
* icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
* 
* 2024-04-14
* 딩카 메인화면 분리 완료
* 설정창 구현
* */

import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_process_of_study.dart';
import 'package:coding_cow_app/widgets/main_today_coding_button.dart';
import 'package:coding_cow_app/widgets/main_bottom_menu.dart';

void main() {
  runApp(Main_Page());
}

class Main_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // root widget
      theme: ThemeData( // font setting (나눔고딕코딩)
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        body: SafeArea( // 앱이 상태창 아래부터 표시되도록 함
          child: Column(
            children: [
              TopBar(),
              Main_Navigator(),
              Main_Adress_Input(),
              Container( // middle part (today status ~ 4 bottom menu)
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Main_Process_Of_Study(),
                    Main_Today_Coding_Button(),
                    Main_BottomMenu(),
                  ],
                ),
              ), // end of middle
            ],
          ),
        ),
      ),
    );
  }
}

