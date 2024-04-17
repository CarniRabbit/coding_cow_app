import 'package:flutter/material.dart';

class Problem_Bottom_Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column( // bottom menu
      children: [
        Container( // top margin
          child: SizedBox(
            height: 50,
          ),
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: '힌트',
              backgroundColor: Color(0xff1f8e22),
              icon: Image.asset(
                'icon/light-bulb.png',
                width: 30,
                height: 30,
              ),
            ),
            BottomNavigationBarItem(
                label: '메모',
                backgroundColor: Color(0xff0e8cea),
                icon: Image.asset(
                  'icon/note.png',
                  width: 30,
                  height: 30,
                ),
            ),
          ],
        ),
      ],
    );
  }
}