/*
 * edit: 2024-08-03
 * 딩카 문제 설명 화면
 * 문제 화면이 나오기 전 문제에 대한 설명 및 입력/출력 형태를 사용자에게 보여줌.
 */


import 'dart:math';
import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/data.dart';
import 'package:coding_cow_app/problem.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:coding_cow_app/widgets/problem_body.dart';
import 'package:flutter/services.dart';

class Problem_Notice_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    hint = false;
    // var input = get_problems[problem_no].input;
    // var output = get_problems[problem_no].output;

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
            future: fromFirestore("Problems"),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                problem_no = Random().nextInt(get_problems.length); // 문제 랜덤 선정
                return SafeArea( // 앱이 상태창 아래부터 표시되도록 함
                  bottom: false,
                  child: Column(
                    children: [
                      TopBar(),
                      Problem_Title(),
                      Container( // problem description
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(20),
                        child: Text(
                          get_problems[problem_no].description,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x40aeaeae),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "입력",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(get_problems[problem_no].input),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffd1dbf7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 20),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "출력",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(get_problems[problem_no].output),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffd1dbf7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Problem_Page()), // 문제 화면으로 이동
                            );
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size(double.infinity, 30),
                            backgroundColor: Color(0xff2355DA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            "문제 풀기",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              return Center(
                child: Text(
                  "문제 로딩중",
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