import 'package:flutter/material.dart';

class Main_Measure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // measure
      flex: 4,
      child: TextButton(
        onPressed: () {

        },
        style: TextButton.styleFrom(
          backgroundColor: Color(0xff5585bd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('icon/speedometer.png'),
              width: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '실력\n측정',
              style: TextStyle(
                letterSpacing: -2,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ); // end of measure,
  }
}