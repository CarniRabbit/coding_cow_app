import 'package:flutter/material.dart';

class Main_QA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Q&A
      flex: 4,
      child: TextButton(
        onPressed: () {

        },
        style: TextButton.styleFrom(
          backgroundColor: Color(0xfff8d34b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('icon/qa.png'),
              width: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '질의\n응답',
              style: TextStyle(
                letterSpacing: -2,
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );  // end of Q&A
  }
}