import 'package:flutter/material.dart';

class Setting_Bracket extends StatefulWidget {
  const Setting_Bracket({Key? key}) : super(key: key);

  @override
  _Setting_Bracket createState() => _Setting_Bracket();
}

class _Setting_Bracket extends State<Setting_Bracket> {
  bool _isKR = true;
  bool _isBSD = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column( // K&R
          children: [
            Image(
              image: AssetImage('icon/K&R.png'),
              width: 100,
              height: 100,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isKR,
                  onChanged: (value) {
                    setState(() {
                      _isKR = value!;
                      _isBSD = false;
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
                  'K&R',
                ),
              ],
            ),
          ],
        ), // end of K&R
        Column( // C language
          children: [
            Image(
              image: AssetImage('icon/BSD.png'),
              width: 100,
              height: 100,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isBSD,
                  onChanged: (value) {
                    setState(() {
                      _isBSD = value!;
                      _isKR = false;
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