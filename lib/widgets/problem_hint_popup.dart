/*
 * edit: 2024-05-22
 * 딩카 문제 화면 - 힌트 팝업
 */

import 'package:coding_cow_app/data_global.dart';
import 'package:flutter/material.dart';

void hint_dialog(context) { // hint popup
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
              Text(
                get_problems[problem_no].hint,
                style: TextStyle(
                  fontSize: 20,
                  // letterSpacing: -3,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xff1f8e22),
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
                  child: Text(
                    '닫기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
} // end of setting popup