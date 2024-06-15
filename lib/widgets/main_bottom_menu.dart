/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴(리그랭킹, 오답노트, 질의응답, 실력측정)
 */

import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/main_league_ranking.dart';
import 'package:coding_cow_app/widgets/main_incorrects.dart';
import 'package:coding_cow_app/widgets/main_measure.dart';
import 'package:coding_cow_app/widgets/main_qa.dart';

class Main_BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // bottom menu
      child: Column( // align(↓)
        children: [
          Row( // align(→)
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Main_League_Ranking(), // 리그랭킹 버튼
              SizedBox(
                width: 20,
              ), // 리그랭킹 <-> 오답노트 사이 공백
              Main_Incorrects(), // 오답노트 버튼
            ],
          ),
          SizedBox(
            height: 20,
          ), // 리그랭킹, 오답노트 <-> 실력 측정, 질의 응답 사이 공백
          Row( // align(→)
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Main_Measure(), // 실력측정 버튼
              SizedBox(
                width: 20,
              ),
              Main_QA(), // 질의응답 버튼
            ],
          ),
        ],
      ),
    ); // end of bottom menu
  }
}