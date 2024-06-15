/*
 * Edit date: 2024-06-22
 * 딩카 결과 화면 - 정답/힌트정답/오답
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Result_Status extends StatelessWidget {
  final int status;
  Result_Status(this.status);

  @override
  Widget build(BuildContext context) {
    return Container( // code part
      alignment: FractionalOffset(0.5, 0.85),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.72,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              // battery icon
              status == 0 ? Image( // 힌트를 보지 않고 정답
                image: AssetImage('icon/full-battery.png'),
              ):
              status == 1 ? Image( // 힌트를 보고 정답
                image: AssetImage('icon/battery.png'),
              ):
              Image( // 오답
                image: AssetImage('icon/low-battery.png'),
              ),
              SizedBox( // 아이콘<->글자 공백
                height: 20,
              ),

              // result text
              status == 0 ? Text( // 힌트를 보지 않고 정답
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff45c9a5),
                    fontWeight: FontWeight.bold,
                  )
              ):
              status == 1 ? Text( // 힌트를 보고 정답
                  'Nice one!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff8bc5c),
                    fontWeight: FontWeight.bold,
                  )
              ):
              Text( // 오답
                  'Keep it up!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff86252),
                    fontWeight: FontWeight.bold,
                  )
              ),
            ],
          ),

          // background color
          decoration: status == 0 ? BoxDecoration( // 힌트를 보지 않고 정답
            color: Color(0xffc3fded),
          ):
          status == 1 ? BoxDecoration( // 힌트를 보고 정답
            color: Color(0xfff7deb6),
          ):
          BoxDecoration( // 오답
            color: Color(0xfffdc3c3),
          ),
        ),
      ),
    ); // end of code part
  }
}