import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/main_setting_C.dart';
import 'package:coding_cow_app/widgets/main_setting_Python.dart';
import 'package:coding_cow_app/widgets/main_setting_K&R.dart';
import 'package:coding_cow_app/widgets/main_setting_BSD.dart';

class Main_Navigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // navigator
        color: Color(0xffE8E8E8), // navigator 바탕색
        child: SizedBox( // navigator bar height
          height: 100,
          child: Row( // navigator element
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
                  child: Row(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('icon/settings.png'),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
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

void setting_dialog(context) { // setting popup
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          // color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "사용 언어",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: -2,
                  color: Color(0xff2355DA),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Setting_C(),
                  Setting_Python(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "괄호 위치",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: -2,
                  color: Color(0xff2355DA),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row( // K&R
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Setting_KR(),
                      Setting_BSD(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
} // end of setting popup