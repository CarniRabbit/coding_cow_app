/*
 * edit: 2024-05-01
 * 딩카 문제 화면 - 프로그램 제목
 */

import 'package:coding_cow_app/data.dart';
import 'package:flutter/material.dart';

class Problem_Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row( // align(→), problem title
      children: [
        Container( // icon
          child: Image(
            image: AssetImage('icon/cmd.png'),
            width: 50,
            height: 50,
          ),
          padding: EdgeInsets.all(20),
        ),
        Container ( // text
          child: Text(
            get_problems[0].title,
            style: TextStyle(
              // letterSpacing: -2,
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ); // end of problem title
  }
}