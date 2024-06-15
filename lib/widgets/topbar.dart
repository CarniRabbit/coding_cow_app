/*
 * edit: 2024-04-01
 * 딩카 공통 - 상단 바
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container ( // top bar
      color: Color(0xff2355DA),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Container(
          alignment: Alignment.topRight, // X박스 align right
          child: SizedBox( // X박스
            width: 50,
            height: 50,
            child: TextButton(
              onPressed: () {
                quit_dialog(context); // x버튼 눌렀을 때 종료
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xffCD4F2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: EdgeInsets.all(5),
              ),
              child: Container(
                color: Color(0xffD27F69),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ), // end of X box,
      ),
    ); // end of topbar
  }
}

void quit_dialog(context) { // X버튼 눌렀을 때 종료
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "앱을 종료하시겠습니까?",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              SystemNavigator.pop(); // 앱 종료
            },
            child: const Text(
              '예',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context, false); // 앱 종료X
            },
            child: const Text(
              '아니요',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      );
    }
  );
}