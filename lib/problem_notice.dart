/*
 * edit: 2024-08-03
 * 딩카 문제 설명 화면
 * 문제 화면이 나오기 전 문제에 대한 설명 및 입력/출력 형태를 사용자에게 보여줌.
 */

import 'package:coding_cow_app/data_problems.dart';
import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/data_incorrects.dart';
import 'package:coding_cow_app/problem.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/problem_title.dart';
import 'package:flutter/services.dart';

class Problem_Notice_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    hint = false;

    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        // Navigator.push(context,
        //     MaterialPageRoute(
        //         builder: (context) => Main_Page()
        //     ),
        // );
      },
      child: MaterialApp( // root widget
        theme: ThemeData( // font setting (나눔고딕코딩)
          fontFamily: 'NanumCoding',
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: FutureBuilder(
            future: mode == 0 ? problemsFromFirestore() // 0: 오늘의 문제, 1: 오답 문제
            : incorrectsFromFirestore(auth.currentUser?.email),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) { // 데이터가 다 로드 되었을 때
                if (mode == 0) { // 오늘의 문제 (현재 무작위 문제, 추후 유저 레벨 기준 오늘의 문제 배열로 대체)
                  print("-----------problem notice----------");
                  print(get_today_problems_ID);
                }

                return SafeArea( // 앱이 상태창 아래부터 표시되도록 함
                  bottom: false,
                  child: SingleChildScrollView(
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
                        ), // end of problem description
                        Container(
                          child: IntrinsicHeight( // input, output 높이를 긴 쪽에 맞춘다.
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 20,
                                      right: 10,
                                    ),
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
                                        Container( // input 내용
                                          margin: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Text(get_problems[problem_no].input),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                        ), // end of input 내용
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
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 20,
                                    ),
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
                                        Container( // output 내용
                                          margin: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Text(get_problems[problem_no].output),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                        ), // end of output 내용
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
                          child: TextButton( // Go to problem page Button
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Problem_Page()), // 문제 화면으로 이동
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 30),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0xff2355DA)
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.all(15),
                              ),
                              textStyle: MaterialStateProperty.resolveWith(
                                    (state) {
                                  if(state.contains(MaterialState.pressed)) {
                                    return TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    );
                                  }
                                  return TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  );
                                },
                              ),
                            ),
                            child: Text(
                              "문제 풀기",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ), // end of Go to problem page Button
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Center( // 데이터가 모두 로드될 때까지 로딩중 화면
                child: Text(
                  "(۶•̀ᴗ•́)۶",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}