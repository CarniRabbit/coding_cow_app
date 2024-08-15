/*
 * edit: 2024-08-15
 * 딩카 문제 화면 - 학습 완료 팝업
 */

import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/result.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data.dart';

void complete_dialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffeafceb),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column( // align(↓)
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: Color(0xff5b6989),
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "오늘의 문제를 모두 풀었어요!",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: -2,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(
                              builder: (context) => Main_Page()
                          ),(route) => false
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff1f8e22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                      // 상화좌우 padding 5px
                    ),
                    child: Text(
                      '메인화면으로 돌아가기',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 오답노트
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff1f8e22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                      // 상화좌우 padding 5px
                    ),
                    child: Text(
                      '오답노트',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ); // end of answer input dialog
    },
  );
}