/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(오답노트)
 */

import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/problem_notice.dart';
import 'package:flutter/material.dart';

class Main_Incorrects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Incorrects
      flex: 4, // 버튼(4):여백(2):버튼(4)
      child: TextButton(
        onPressed: () { // press event
          mode = 1;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Problem_Notice_Page()), // 장면 이동
          );
        },
        style:
        ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xff9bbb49),
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
        child: Row( // align (→)
          children: [
            Image( // icon
              image: AssetImage('icon/to-do-list.png'),
              width: 80,
            ),
            SizedBox( // 공백
              width: 20,
            ),
            Text( // text
              '오답\n노트',
              style: TextStyle(
                letterSpacing: -2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ); // end of incorrects
  }
}