import 'package:flutter/material.dart';

void answer_input_dialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '정답을 입력해주세요',
                ),
              ),
              TextButton(
                  onPressed: () {
                    
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