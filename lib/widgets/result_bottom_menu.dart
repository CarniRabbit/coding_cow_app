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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff2355DA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
                            // 상화좌우 padding 5px
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
                            if (mode == 0) { // 오늘의 문제 (현재 무작위 문제, 추후 유저 레벨 기준 오늘의 문제 배열로 대체)
                              problem_no++; // 문제 랜덤 선정
                            } else { // 오답 문제 (0부터 순차적으로 증가)
                              // 오답 list의 끝까지 왔을 경우 problem_no를 0으로 초기화
                              if (problem_no <= get_problems.length-1) {
                                problem_no++;
                              } else {
                                problem_no = 0;
                              }
                            }
                            memo = ""; // 메모 리셋

                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                    builder: (context) => Problem_Notice_Page()
                                ),(route) => false
                            );

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Problem_Page()), // 문제 화면으로 이동
                            // );
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff2355DA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
                            // 상화좌우 padding 5px
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