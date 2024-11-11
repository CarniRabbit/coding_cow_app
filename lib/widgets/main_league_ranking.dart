/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(리그랭킹)
 */

import 'package:coding_cow_app/ranking.dart';
import 'package:flutter/material.dart';

class Main_League_Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // League & Ranking
      flex: 4,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => RankingPage())
          );
        },
        style:
        ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xffd76834),
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
            Image(
              image: AssetImage('icon/free-icon-trophy.png'),
              width: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '리그\n랭킹',
              style: TextStyle(
                letterSpacing: -2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ); // end of League & Ranking
  }
}