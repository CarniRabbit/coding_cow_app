/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(실력측정)
 */

import 'package:coding_cow_app/statistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.uid ?? '';
}

class Main_Measure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // measure
      flex: 4,
      child: TextButton(
        onPressed: () {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StatPage(uid: uid))
          );
        },
        style:
        ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xff5585bd),
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
        child: Row( // align(→)
          children: [
            Image( // icon
              image: AssetImage('icon/speedometer.png'),
              width: 80,
            ),
            SizedBox( // 공백
              width: 20,
            ),
            Text( // text
              '실력\n측정',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ); // end of measure,
  }
}