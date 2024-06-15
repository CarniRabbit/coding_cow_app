/*
 * edit: 2024-05-01
 * 딩카 메인 화면 - 설정 팝업(괄호 위치)
 */

import 'package:flutter/material.dart';

class Setting_Bracket extends StatefulWidget {
  const Setting_Bracket({Key? key}) : super(key: key);

  @override
  _Setting_Bracket createState() => _Setting_Bracket();
}

class _Setting_Bracket extends State<Setting_Bracket> {
  // 괄호 기본 설정은 K&R
  bool _isKR = true;
  bool _isBSD = false;

  @override
  Widget build(BuildContext context) {
    return Row( // align(→)
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column( // align(↓), K&R
          children: [
            Image(
              image: AssetImage('icon/K&R.png'),
              width: 100,
              height: 100,
            ),
            Row( // align(→)
              children: [
                Checkbox( // checkbox state(한쪽이 체크되면 다른 한쪽은 체크X)
                  value: _isKR,
                  onChanged: (value) {
                    setState(() {
                      _isKR = value!;
                      _isBSD = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // 모든 꼭짓점을 20만큼 둥글게
                  ),
                  checkColor: Colors.white, // check icon color
                  activeColor: Color(0xff2355DA), // check = true일때 background color
                  materialTapTargetSize: MaterialTapTargetSize.padded, // min size
                ),
                Text(
                  'K&R',
                ),
              ],
            ),
          ],
        ), // end of K&R
        Column( // align(↓), BSD
          children: [
            Image(
              image: AssetImage('icon/BSD.png'),
              width: 100,
              height: 100,
            ),
            Row( // align(→)
              children: [
                Checkbox( // checkbox state(한쪽이 체크되면 다른 한쪽은 체크X)
                  value: _isBSD,
                  onChanged: (value) {
                    setState(() {
                      _isBSD = value!;
                      _isKR = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // 모든 꼭짓점을 20만큼 둥글게
                  ),
                  checkColor: Colors.white,  // check icon color
                  activeColor: Color(0xff2355DA), // check = true일때 background color
                  materialTapTargetSize: MaterialTapTargetSize.padded, // min size
                ),
                Text(
                  'BSD',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}