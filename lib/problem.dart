/*
* 2024-04-14
* 딩카 문제화면1
* 각 위젯마다 시작, 끝 주석으로 표기하기
* 속성에 대한 간략한 설명 주석으로 넣기
* 한글 작성시 항상 자간 -2 (letterSpacing: -2)
* 다음 속성이 없더라도 무조건 반점 찍기
* icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
* */


import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';

void main() {
  runApp(Problem_Page());
}

class Problem_Page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp( // root widget
      theme: ThemeData( // font setting (나눔고딕코딩)
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        body: SafeArea( // 앱이 상태창 아래부터 표시되도록 함
          bottom: false,
          child: Column(
            children: [
              TopBar(),
              Row( // problem title
                children: [
                  Container(
                    child: Image(
                      image: AssetImage('icon/cmd.png'),
                      width: 50,
                      height: 50,
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  Container (
                    child: Text(
                      '짝수/홀수 판별 프로그램',
                      style: TextStyle(
                        letterSpacing: -2,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ), // end of problem title
              Expanded( // problem body
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('icon/problem_bg.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned( // level
                      top: 10,
                      left: 80,
                      child: Text("Lv.???"),
                    ), // end of level
                    Positioned( // problem type
                      top: 85,
                      left: 275,
                      child: Text("단답형 문제"),
                    ), // end of problem type
                    Positioned( // code part
                      top: 125,
                      left: 50,
                      width: 310,
                      height: 385,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '#include <stdio.h>\nvoid main() {\n  int n=3;\n  if(   ) {\n     printf("짝수");\n  }\n  else {\n    printf("홀수");\n  }\n}',
                          style: TextStyle(
                            letterSpacing: -2,
                            fontSize: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ), // end of code part
                  ],
                ),
              ), // end of problem body
              Column( // bottom menu
                children: [
                  Container( // top margin
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        label: '힌트',
                        icon: ImageIcon(
                          AssetImage('icon/light-bulb.png'),
                        ),
                      ),
                      BottomNavigationBarItem(
                          label: '메모',
                          icon: ImageIcon(
                              AssetImage('icon/note.png')
                          ))
                    ],
                  ),
                ],
              )
            ],
          ),
        ), // end of middle
      ),
    );
  }
}