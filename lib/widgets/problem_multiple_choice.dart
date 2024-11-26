/*
 * edit: 2024-05-22
 * 딩카 문제 화면 - 객관식 문제 화면
 */

import 'package:coding_cow_app/widgets/problem_bottom_menu.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:flutter/material.dart';

class Problem_Multiple_Choice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // problem body
      body:SafeArea(
        bottom:false,
        child:Column( // align(↓)
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
                    '무슨 코드인지 맞춰보세요!',
                    style: TextStyle(
                      letterSpacing: -2,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child:Stack(
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
                    child: Text(
                      "Lv.???",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ), // end of level
                  Positioned( // problem type
                    top: 85,
                    left: 275,
                    child: Text(
                      "객관식 문제",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned( // code part
                    top: 125,
                    left: 50,
                    width: 310,
                    height: 385,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children:[
                          SizedBox(
                            width: double.infinity,
                            child:ElevatedButton(
                              child:Text(
                                  '3부터 100까지의 합을 구하는 프로그램',
                                  style: TextStyle(
                                      color: Colors.black
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width:double.infinity,
                            child:ElevatedButton(
                              child:Text(
                                  '3의 배수를 구하는 프로그램',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                  )
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width:double.infinity,
                            child:ElevatedButton(
                              child:Text('3의 약수를 구하는 프로그램',style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width:double.infinity,
                            child:ElevatedButton(
                              child:Text('홀수 짝수 판별 프로그램',style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                          SizedBox(
                              height: 10
                          ),
                          SizedBox(
                            width:double.infinity,
                            child:ElevatedButton(
                              child:Text('세제곱을 구하는 프로그램',style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Problem_Bottom_Menu(),
          ],
        ),
      ),// end of code part
    );// end of problem body
  }
}