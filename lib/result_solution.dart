/*
 * Edit date: 2024-08-20
 * 딩카 결과 화면 - 문제 해설
*/

import 'package:coding_cow_app/data.dart';
import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
          body: FutureBuilder( // 앱이 상태창 아래부터 표시되도록 함
            future: fromFirestore("Problems"),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
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
                );
              }

              return Center( // 데이터가 로드되지 않았을 때
                child: Text(
                  "문제 로딩중",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ), // end of middle
        ),
      ),
    ); // end of code part
  }
}