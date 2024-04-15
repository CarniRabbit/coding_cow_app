import 'package:flutter/material.dart';

class Main_Today_Coding_Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // today coding button
      margin: EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {

          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff2355DA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            padding: EdgeInsets.all(15),
          ),
          child: Text(
            '오늘의 코딩',
            style: TextStyle(
              letterSpacing: -2,
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ); // end of today coding button
  }
}