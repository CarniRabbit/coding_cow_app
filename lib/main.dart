/*
 * 2024-04-14
 * 딩카 메인화면
 */

import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/topbar.dart';
import 'package:coding_cow_app/widgets/main_navigator.dart';
import 'package:coding_cow_app/widgets/main_address_input.dart';
import 'package:coding_cow_app/widgets/main_process_of_study.dart';
import 'package:coding_cow_app/widgets/main_today_coding_button.dart';
import 'package:coding_cow_app/widgets/main_bottom_menu.dart';
import 'package:coding_cow_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Main_Page());
}

class Main_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // root widget
      theme: ThemeData( // font setting (나눔고딕코딩)
        fontFamily: 'NanumCoding',
      ),
      home: Scaffold(
        body: SafeArea( // 앱이 상태창 아래부터 표시되도록 함
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
        ),
      ),
    );
  }
}

