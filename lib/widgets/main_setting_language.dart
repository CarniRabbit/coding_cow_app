/*
 * edit: 2024-05-01
 * 딩카 메인 화면 - 설정 팝업(언어 종류)
 */

import 'package:flutter/material.dart';

class Setting_Language extends StatefulWidget {
  const Setting_Language({Key? key}) : super(key: key);

  @override
  _Setting_Language_State createState() => _Setting_Language_State();
}

class _Setting_Language_State extends State<Setting_Language> {
  bool _isC = true;
  bool _isPython = false;

  @override
  Widget build(BuildContext context) {
    return Row( // align(→)
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(  // align(↓), C language
          children: [
            Image(
              image: AssetImage('icon/c-.png'),
              width: 50,
              height: 50,
            ),
            Row( // align(→)
              children: [
                Checkbox( // checkbox state(한쪽이 체크되면 다른 한쪽은 체크X)
                  value: _isC,
                  onChanged: (value) {
                    setState(() {
                      _isC = value!;
                      _isPython = false;
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
                  'C언어',
                ),
              ],
            ),
          ],
        ), // end of C language
        Column( // align(↓), Python language
          children: [
            Image(
              image: AssetImage('icon/python-file.png'),
              width: 50,
              height: 50,
            ),
            Row( // align(→)
              children: [
                Checkbox( // checkbox state(한쪽이 체크되면 다른 한쪽은 체크X)
                  value: _isPython,
                  onChanged: (value) {
                    setState(() {
                      _isPython = value!;
                      _isC = false;
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
                  'Python',
                ),
              ],
            ),
          ],
        ), // end of python
      ],
    );
  }
}