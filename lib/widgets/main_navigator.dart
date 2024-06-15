/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(오답노트)
 */

import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/main_setting_popup.dart';

class Main_Navigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // navigator
        color: Color(0xffE8E8E8), // navigator 바탕색
        child: SizedBox( // navigator bar height
          height: 100,
          child: Row( // navigator element, // align(→)
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 자동으로 균등하게 배치
            children: [
              // Expanded를 2개 배치해두면 자동으로 너비가 1:1로 맞춰짐 (3개면 33.33, 4개면 25...)
              Expanded( // shop button
                child: TextButton(
                  onPressed: () {

                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // 버튼의 모서리를 10px 만큼 둥글게
                    ),
                    padding: EdgeInsets.all(5),
                    // 버튼 내부에 padding 5px
                  ),
                  child: Row( // align(→)
                    mainAxisAlignment: MainAxisAlignment.center,
                    //  Row의 모든 요소를 가운데 모아 정렬
                    children: [
                      Image( // store icon image
                        image: AssetImage('icon/store.png'),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox( // icon<->글자 여백
                        width: 20,
                      ),
                      Text(
                        '상점',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: -2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ), // end of shop button
              SizedBox( // Divider
                width: 1,
                child: Container(
                  color: Color(0xffA8A8A8),
                ),
              ), // end of divider
              Expanded( // settings button
                child: TextButton(
                  onPressed: () {
                    setting_dialog(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      // 모서리 둥글게 5px
                    ),
                    padding: EdgeInsets.all(5),
                    // 상화좌우 padding 5px
                  ),
                  child: Row( // align(→)
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image( // icon
                        image: AssetImage('icon/settings.png'),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox( // 공백
                        width: 20,
                      ),
                      Text( // text
                        '설정',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: -2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ), // end of settings button
            ],
          ),
        )
    ); // end of navigator
  }
}