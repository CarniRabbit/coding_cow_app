/*
* 2024-04-14
* 딩카 문제화면 - 코드 부분
* 각 위젯마다 시작, 끝 주석으로 표기하기
* 속성에 대한 간략한 설명 주석으로 넣기
* 한글 작성시 항상 자간 -2 (letterSpacing: -2)
* 다음 속성이 없더라도 무조건 반점 찍기
* icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
* */


import 'package:coding_cow_app/widgets/problem_answer_input_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Problem_Code_Part());
}

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
            TextSpan(
              children: <InlineSpan> [
                TextSpan(
                  text: '''#include <stdio.h>
void main() {
  int n=3;
  if(''',
                ),
                WidgetSpan(
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
                      '정답 입력',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                  )
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