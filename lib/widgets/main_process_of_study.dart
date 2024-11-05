/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 오늘의 공부 현황(%)
 */

import 'package:coding_cow_app/data_global.dart';
import 'package:flutter/material.dart';

class Main_Process_Of_Study extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // process of study
      margin: EdgeInsets.only(bottom: 20),
      // today status의 아랫 방향으로 margin 20px
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // 모서리 10px 만큼 둥글게
        color: Color(0xffE8E8E8),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Row( // align(→)
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image( // dingca character
                  image: AssetImage('character/codingcow.gif'),
                  width: 120,
                  height: 120,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Lv.'+get_level.toString(),
                  style: TextStyle(
                    color: Color(0xff2355DA),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '다음 레벨까지 '+get_restEXP.toString()+'문제',
                  style: TextStyle(
                    color: Color(0xff2355DA),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    color: Color(0xff2355DA),
                    backgroundColor: Color(0xffd1dbf7),
                    strokeWidth: 20,
                    value: today_progress,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      (today_progress*100).toString()+"%",
                      style: TextStyle(
                        color: Color(0xff2355DA),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ); // end of process of study
  }
}