import 'package:flutter/material.dart';

class Main_Incorrects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Incorrects
      flex: 4,
      child: TextButton(
        onPressed: () {

        },
        style: TextButton.styleFrom(
          backgroundColor: Color(0xff9bbb49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('icon/to-do-list.png'),
              width: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '오답\n노트',
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
    ); // end of incorrects
  }
}