/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 정답 입력창
 */

import 'package:coding_cow_app/result.dart';
import 'package:coding_cow_app/widgets/main_measure.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data.dart';

void answer_input_dialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      final _answerEditController = TextEditingController();

      return Dialog( // answer input dialong
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.help_outline),
                color: Color(0xff2355DA),
                iconSize: 50,
                tooltip: "연산자와 피연산자는 띄어쓰기가 불가합니다.\n아래 예시를 참고하여 정답을 작성해주세요.\nex)\nresult = a * b / c (X)\nresult=a*b/c (O)",
                onPressed: () {

                },
              ),
              Text(
                '답안 작성 예시',
                style: TextStyle(
                  color: Color(0xff2355DA),
                  letterSpacing: -2,
                ),
              ),
              TextField( // input
                controller: _answerEditController,
                decoration: InputDecoration(
                  hintText: '정답을 입력해주세요',
                ),
              ),
              TextButton(
                  onPressed: () async { // press event
                    // 입력한 값 == Problem DB의 현재 문제의 정답 여부 판별
                    
                    var text = _answerEditController.text; // 입력한 값
                    int status = 0;

                    // print("!!!"+text);
                    // print("???"+get_problems[problem_no].answer);

                    if (text == get_problems[problem_no].answer) {
                      // hint를 보지 않고 정답을 맞췄을 때
                      if (!hint)
                        status = 0;

                      // hint를 보고 정답을 맞췄을 때
                      else
                        status = 1;

                      today_solved++;
                      today_progress = today_solved / 10;
                    }

                    // 답을 틀렸을 때
                    else {
                      status = 2;
                      await addIncorrectProblem(get_problems[problem_no].ID); // 답을 틀렸을 때 Incorrect DB에 저장
                    }
                    
                    // 결과 화면으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Result_Page(status, uid: getCurrentUserId())),
                    );
                  }, 
                  child: Text(
                    '입력',
                    style: TextStyle(
                      color: Color(0xff2355DA),
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ],
          ),
          padding: EdgeInsets.all(10), // padding 상하좌우 10px
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
      ); // end of answer input dialog
    },
  );
}