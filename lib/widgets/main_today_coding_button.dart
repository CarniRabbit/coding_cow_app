/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 오늘의 코딩문제 버튼
 */

import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/widgets/transition_route_state.dart';
import 'package:flutter/material.dart';

import '../problem_notice.dart';
import 'move_middle_to_circle_transition_route.dart';

class Main_Today_Coding_Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mode = 0;

    return Container( // today coding button
      margin: EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: TextButton( // today coding button
          onPressed: () { // press event

            Navigator.push(
              context,
              TransitionRouteState(
                page: Problem_Notice_Page(),
                transition: moveMiddleToCircleTransition,
                duration: const Duration(seconds: 1),
              ),
              // MaterialPageRoute(builder: (context) => Problem_Notice_Page()), // 문제 화면으로 이동
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
            '오늘의 코딩',
            style: TextStyle(
              letterSpacing: -2,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ); // end of today coding button
  }
}