/*
 * edit: 2024-05-22
 * 딩카 결과 화면 - 하단 메뉴
 */

import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/problem_notice.dart';
import 'package:coding_cow_app/result_solution.dart';
import 'package:flutter/material.dart';

class Result_Bottom_Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SingleChildScrollView(
          child: Column( // align(↓)
            children: <Widget>[
              SizedBox( // top margin
                height: 20,
              ),
              Container(
                // color: Colors.black,
                padding: EdgeInsets.only(left: 25, top: 0, right: 25, bottom: 0),
                child: Row( // Bottom Navigation Bar
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton( // Hint Button
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Result_Solution()
                              ), // 문제 화면으로 이동
                            );
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('icon/solution.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '문제해설',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff2355DA),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
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
                        ), // end of Hint Button
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: TextButton( // next problem
                          onPressed: () {
                            // TodayProblems에서 삭제
                            get_problems.removeAt(0);
                            get_today_problems_ID.removeAt(0);

                            if (mode == 1) { // 오늘의 문제 (현재 무작위 문제, 추후 유저 레벨 기준 오늘의 문제 배열로 대체)
                              // 오답 list의 끝까지 왔을 경우 problem_no를 0으로 초기화
                              if (problem_no <= get_problems.length-1) {
                                problem_no++;
                              } else {
                                problem_no = 0;
                              }
                            }
                            memo = ""; // 메모 리셋

                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => Problem_Notice_Page()
                                )
                            );
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('icon/next.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '다음문제',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff2355DA),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
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
                        ), // end of next problem
                      ),
                    ),
                  ],
                ), // end of Bottom Navigation Bar,
              ),
            ],
          ),
        ),
      );
  }
}