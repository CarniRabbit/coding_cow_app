/*
 * 2024-04-14
 * 딩카 메인화면
 */

import 'package:coding_cow_app/data_problems.dart';
import 'package:coding_cow_app/data_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_process_of_study.dart';
import 'package:coding_cow_app/widgets/main_today_coding_button.dart';
import 'package:coding_cow_app/widgets/main_bottom_menu.dart';
import 'package:coding_cow_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coding_cow_app/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  if(uid != null){
    onAppStart(uid);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NanumCoding',
      ),
      home: Login_Page(),
    );
  }
}

class Main_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    memo = ""; // 메모 리셋
    return MaterialApp( // root widget
      theme: ThemeData( // font setting (나눔고딕코딩)
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: getUserInfo(auth.currentUser?.email),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              return SafeArea( // 앱이 상태창 아래부터 표시되도록 함
                child: Column(
                  children: [
                    TopBar(),
                    Main_Navigator(),
                    Main_Adress_Input(),
                    Container( // middle part (today status ~ 4 bottom menu)
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Main_Process_Of_Study(),
                          Main_Today_Coding_Button(),
                          Main_BottomMenu(),
                        ],
                      ),
                    ), // end of middle
                  ],
                ),
              );
            }

            return Center( // 데이터가 모두 로드될 때까지 로딩중 화면
              child: Text(
                "사용자 정보 로딩중",
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}

