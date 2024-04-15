import 'package:flutter/material.dart';

class Main_Process_Of_Study extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // process of study
      margin: EdgeInsets.only(bottom: 20),
      // today status의 아랫 방향으로 margin 20px
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // 모서리 10px 만큼 둥글게
        color: Color(0xffE8E8E8),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image( // dingca character
              image: AssetImage('character/codingcow.png'),
              width: 120,
              height: 120,
            ),
            Image( // today process percentage
              image: AssetImage('icon/percentage.png'),
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    ); // end of process of study
  }
}