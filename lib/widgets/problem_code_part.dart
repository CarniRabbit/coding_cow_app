/*
 * edit: 2024-06-18
 * 딩카 문제 화면 - 코드
 */


import 'package:coding_cow_app/data.dart';
import 'package:coding_cow_app/widgets/problem_answer_input_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Problem_Code_Part extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<Problems>> problem_db = fromFirestore("Problems");

    return Container( // code part
      alignment: FractionalOffset(0.5, 0.85),
      child: FractionallySizedBox(
        widthFactor: 0.75,
        heightFactor: 0.72,
        child: Container(
          padding: EdgeInsets.all(10),
          child: InkWell( // event를 넣을 수 없는 widget에 event를 부여해주는 widget
            onTap: () {
              answer_input_dialog(context); // 코드 부분 터치시 정답 입력창 실행
            },
            child: Html(
              data: problems[problem_no][4].toString(), // 코드 가져오기
              style: {
                ".blue": Style( // 파란 글자
                  color: Colors.blueAccent,
                ),
                ".red": Style( // 빨간 글자
                  color: Colors.red,
                ),
                ".hint": Style( // 힌트 highlight
                  color: Color(0xff1f8e22),
                ),
                ".answer": Style( // blank
                  backgroundColor: Color(0xff2355DA),
                  color: Colors.white,
                ),
                "div.first": Style( // intent 1
                  margin: Margins.only(left: 20),
                ),
                "div.second": Style( // intent 2
                  margin: Margins.only(left: 40),
                ),
                "div.third": Style( // intent 3
                  margin: Margins.only(left: 60),
                ),
                "div.fourth": Style( // intent 4
                  margin: Margins.only(left: 80),
                ),
              },
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    ); // end of code part
  }
}