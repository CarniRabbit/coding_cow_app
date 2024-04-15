import 'package:flutter/material.dart';

class Setting_BSD extends StatefulWidget {
  const Setting_BSD({Key? key}) : super(key: key);

  @override
  _Setting_BSD createState() => _Setting_BSD();
}

class _Setting_BSD extends State<Setting_BSD> {
  bool _isBSD = false;

  @override
  Widget build(BuildContext context) {
    return Column( // C language
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
    );
  }
}