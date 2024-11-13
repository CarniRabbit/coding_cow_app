/*
 * edit: 2024-05-01
 * 딩카 메인 화면 - 설정 팝업
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/main_setting_language.dart';
import 'package:coding_cow_app/widgets/main_setting_bracket.dart';

import '../login.dart';

void setting_dialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        // setting popup
        child: Container(
          padding: EdgeInsets.all(20),
          // color: Colors.white,
          child: Column(
            // align(↓)
            mainAxisSize: MainAxisSize.min, // 크기를 child widget들이 차지하는 최소공간으로
            children: [
              Text(
                "사용 언어",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: -2,
                  color: Color(0xff2355DA),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Setting_Language(), // 사용 언어 checkboxes
              SizedBox(
                height: 20,
              ),
              Text(
                "괄호 위치",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: -2,
                  color: Color(0xff2355DA),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Setting_Bracket(), // 괄호 위치 checkboxes
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(); // 팝업 닫기
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Login_Page()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff2355DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: EdgeInsets.all(15),
                ),
                child: Text(
                  '로그아웃 하기',
                  style: TextStyle(
                    letterSpacing: -2,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
