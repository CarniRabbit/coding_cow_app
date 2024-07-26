/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 정답 입력창
 */

import 'package:coding_cow_app/result.dart';
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
              TextField( // input
                controller: _answerEditController,
                decoration: InputDecoration(
                  hintText: '정답을 입력해주세요',
                ),
              ),
              TextButton(
                  onPressed: () { // press event
                    // 입력한 값 == Problem DB의 현재 문제의 정답 여부 판별
                    
                    var text = _answerEditController.text; // 입력한 값
                    int status = 0;

                    print("!!!"+text);
                    print("???"+get_problems[problem_no].answer);
                    
                    // hint를 보지 않고 정답을 맞췄을 때
                    if (text == get_problems[problem_no].answer && !hint)
                      status = 0;

                    // hint를 보고 정답을 맞췄을 때
                    else if (text == get_problems[problem_no].answer)
                      status = 1;

                    // 답을 틀렸을 때
                    else
                      status = 2;
                    
                    // 결과 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Result_Page(status)),
                    );
                  }, 
                  child: Text(
                    '입력',
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