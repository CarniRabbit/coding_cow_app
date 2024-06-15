/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 코드
 */


import 'package:coding_cow_app/widgets/problem_answer_input_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Problem_Code_Part extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide navigation bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return Container( // code part
      alignment: FractionalOffset(0.5, 0.85),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.72,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text.rich(
            TextSpan( // inline으로 text를 배치할 수 있게 해주고, textspan마다 다른 설정 가능
              children: <InlineSpan> [
                TextSpan(
                  text: '''#include <stdio.h>
void main() {
  int n=3;
  if(''',
                ),
                WidgetSpan( // inline으로 widget을 배치할 수 있게 해줌
                  alignment: PlaceholderAlignment.middle,
                  child: TextButton(
                    onPressed: () {
                      answer_input_dialog(context);
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      backgroundColor: Color(0xff2355DA),
                    ),
                    child: Text(
                      '           ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: ''') {
    printf("짝수");
  }
  else {
    printf("홀수");
  }
}
                ''',
                ),
              ],
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