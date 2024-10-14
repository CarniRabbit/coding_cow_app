/*
 * Edit date: 2024-08-20
 * 딩카 결과 화면 - 문제 해설
*/

import 'package:coding_cow_app/data_problems.dart';
import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Result_Solution extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          body: SafeArea(
            child: Column(
              children: [
                TopBar(),
                Problem_Title(),
                Expanded(
                  child: Container(
                    child: Markdown(
                      data: get_problems[problem_no].solution,
                    ),
                  ),
                ),
              ],
            ),
          ), // end of middle
        ),
      ),
    ); // end of code part
  }
}