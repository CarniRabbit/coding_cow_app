/*
 * edit: 2024-04-14
 * 딩카 문제 화면
 */


import 'package:coding_cow_app/problem_notice.dart';

import 'data_global.dart';
import 'package:coding_cow_app/main.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/problem_body.dart';
import 'package:coding_cow_app/widgets/problem_bottom_menu.dart';

class Problem_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    hint = false;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => Problem_Notice_Page()
          )
        );
      },
      child: MaterialApp( // root widget
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
          ),
        ),
      ),
    );
  }
}