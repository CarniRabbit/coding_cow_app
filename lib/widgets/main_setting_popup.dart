import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/main_setting_language.dart';
import 'package:coding_cow_app/widgets/main_setting_bracket.dart';

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
              Setting_Language(),
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
              Setting_Bracket(),
            ],
          ),
        ),
      );
    },
  );
} // end of setting popup