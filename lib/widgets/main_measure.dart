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
                  builder: (context) => Stat_Page(uid: uid))
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Color(0xff5585bd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
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
                letterSpacing: -2,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ); // end of measure,
  }
}