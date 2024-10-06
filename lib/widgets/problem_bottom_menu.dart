/*
 * edit: 2024-05-01
 * 딩카 문제 화면 - 하단 메뉴
 */

import 'package:coding_cow_app/widgets/problem_memo_popup.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/problem_hint_popup.dart';
import 'package:coding_cow_app/data_global.dart';

class Problem_Bottom_Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox( // top margin
          height: 50,
        ),
        SizedBox(
          height: 80,
          child: Row( // Bottom Navigation Bar
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:  SizedBox(
                  height: 80,
                  child: TextButton( // Hint Button
                    onPressed: () {
                      hint = true;
                      hint_dialog(context);
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('icon/light-bulb.png'),
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '힌트',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff1f8e22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      padding: EdgeInsets.all(10),
                      // 상하좌우 padding 10px
                    ),
                  ), // end of Hint Button
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff2355DA),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 80,
                  child: TextButton(
                    onPressed: () {
                      memo_dialog(context);
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('icon/note.png'),
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '메모',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff0e8cea),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      padding: EdgeInsets.all(10),
                      // 상화좌우 padding 5px
                    ),
                  ),
                ),
              ),
            ],
          ), // end of Bottom Navigation Bar,
        ),

      ],
    );
  }
}