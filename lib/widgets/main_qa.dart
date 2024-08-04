/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(질의응답)
 */

import 'package:coding_cow_app/problem_notice.dart';
import 'package:flutter/material.dart';

class Main_QA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Q&A
      flex: 4,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Problem_Notice_Page()), // 문제 화면으로 이동
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Color(0xfff8d34b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );  // end of Q&A
  }
}