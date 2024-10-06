/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 주소창(닉네임 표시)
 */

import 'package:coding_cow_app/data_problems.dart';
import 'package:flutter/material.dart';

class Main_Adress_Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // address input
      decoration: BoxDecoration(
        border: Border.all( // 상하좌우 모두 3px border
          color: Color(0xffAEAEAE),
          width: 3,
        ),
      ),
      // padding: EdgeInsets.all(5),
      child: SizedBox( //
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // nickname과 more button을 양쪽 끝에 배치
          children: [
            Container( // nickname
              margin: EdgeInsets.only(left: 15),
              // nickname 왼쪽에 여백
              child: Text(
                get_nickname+'.com',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ), // end of nickname
            Container( // more button
              color: Color(0xffd1dbf7),
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff5b6989),
                    size: 50,
                  )
              ),
            ), // end of more button
          ],
        ),
      ),
    ); // end of address input
  }
}