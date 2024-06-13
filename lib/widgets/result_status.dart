/*
* Edit date: 2024-06-05
* 딩카 문제화면 - 결과 화면
* 각 위젯마다 시작, 끝 주석으로 표기하기
* 속성에 대한 간략한 설명 주석으로 넣기
* 한글 작성시 항상 자간 -2 (letterSpacing: -2)
* 다음 속성이 없더라도 무조건 반점 찍기
* icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
* 조건에 따라 화면이 바뀌는 경우 삼항연산자 사용할 것. 오히려 if, switch-case가 더 어려움.
* */


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
              status == 0 ? Image(
                image: AssetImage('icon/full-battery.png'),
              ):
              status == 1 ? Image(
                image: AssetImage('icon/battery.png'),
              ):
              Image(
                image: AssetImage('icon/low-battery.png'),
              ),
              SizedBox(
                height: 20,
              ),
              status == 0 ? Text(
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff45c9a5),
                    fontWeight: FontWeight.bold,
                  )
              ):
              status == 1 ? Text(
                  'Nice one!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff8bc5c),
                    fontWeight: FontWeight.bold,
                  )
              ):
              Text(
                  'Keep it up!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff86252),
                    fontWeight: FontWeight.bold,
                  )
              ),
            ],
          ),
          decoration: status == 0 ? BoxDecoration(
            color: Color(0xffc3fded),
          ):
          status == 1 ? BoxDecoration(
            color: Color(0xfff7deb6),
          ):
          BoxDecoration(
            color: Color(0xfffdc3c3),
          ),
        ),
      ),
    ); // end of code part
  }
}