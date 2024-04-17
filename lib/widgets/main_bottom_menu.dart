import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/main_league_ranking.dart';
import 'package:coding_cow_app/widgets/main_incorrects.dart';
import 'package:coding_cow_app/widgets/main_measure.dart';
import 'package:coding_cow_app/widgets/main_qa.dart';

class Main_BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // bottom menu
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Main_League_Ranking(),
              SizedBox(
                width: 20,
              ), // 리그랭킹 <-> 오답노트 사이 여백
              Main_Incorrects(),
            ],
          ),
          SizedBox(
            height: 20,
          ), // 리그랭킹, 오답노트 <-> 실력 측정, 질의 응답 사이 여백
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Main_Measure(),
              SizedBox(
                width: 20,
              ),
              Main_QA(),
            ],
          ),
        ],
      ),
    );
  }
}