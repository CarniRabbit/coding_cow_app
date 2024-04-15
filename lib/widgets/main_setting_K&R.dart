import 'package:flutter/material.dart';

class Setting_KR extends StatefulWidget {
  const Setting_KR({Key? key}) : super(key: key);

  @override
  _Setting_KR createState() => _Setting_KR();
}

class _Setting_KR extends State<Setting_KR> {
  bool _isKR = true;

  @override
  Widget build(BuildContext context) {
    return Column( // C language
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
    );
  }
}