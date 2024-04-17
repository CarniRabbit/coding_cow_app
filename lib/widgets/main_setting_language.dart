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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column( // C language
          children: [
            Image(
              image: AssetImage('icon/c-.png'),
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isC,
                  onChanged: (value) {
                    setState(() {
                      _isC = value!;
                      _isPython = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  checkColor: Colors.white,
                  activeColor: Color(0xff2355DA),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                ),
                Text(
                  'C언어',
                ),
              ],
            ),
          ],
        ), // end of C language
        Column( // Python language
          children: [
            Image(
              image: AssetImage('icon/python-file.png'),
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isPython,
                  onChanged: (value) {
                    setState(() {
                      _isPython = value!;
                      _isC = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  checkColor: Colors.white,
                  activeColor: Color(0xff2355DA),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
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