import 'package:flutter/material.dart';

class Main_League_Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // League & Ranking
      flex: 4,
      child: TextButton(
        onPressed: () {

        },
        style: TextButton.styleFrom(
          backgroundColor: Color(0xffd76834),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('icon/free-icon-trophy.png'),
              width: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '리그\n랭킹',
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
    ); // end of League & Ranking
  }
}