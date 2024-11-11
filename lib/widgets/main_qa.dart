/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(질의응답)
 */

import 'package:coding_cow_app/result_solution.dart';
import 'package:coding_cow_app/problem_notice.dart';
import 'package:flutter/material.dart';

class Main_QA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Q&A
      flex: 4,
      child: TextButton(
        onPressed: () {
          // 질의응답 버튼 터치시
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xfff8d34b),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(10),
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
        child: Row( // align(→)
          children: [
            Image( // icon
              image: AssetImage('icon/qa.png'),
              width: 80,
            ),
            SizedBox( // 공백
              width: 20,
            ),
            Text( // text
              '질의\n응답',
              style: TextStyle(
                letterSpacing: -2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );  // end of Q&A
  }
}