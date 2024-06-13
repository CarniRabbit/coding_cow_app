import 'package:coding_cow_app/result.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data.dart';

void answer_input_dialog(context) {
  print(problems[0][5]); // answer index = 5

  showDialog(
    context: context,
    builder: (context) {
      final _answerEditController = TextEditingController();

      return Dialog(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _answerEditController,
                decoration: InputDecoration(
                  hintText: '정답을 입력해주세요',
                ),
              ),
              TextButton(
                  onPressed: () {
                    var text = _answerEditController.text;
                    int status = 0;

                    print(hint);

                    if (text.replaceAll(RegExp('\\s'), "") == problems[0][5] && !hint)
                      status = 0;

                    else if (text.replaceAll(RegExp('\\s'), "") == problems[0][5])
                      status = 1;

                    else
                      status = 2;

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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
      );
    },
  );
}