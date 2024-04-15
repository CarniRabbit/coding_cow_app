import 'package:flutter/material.dart';

class Setting_C extends StatefulWidget {
  const Setting_C({Key? key}) : super(key: key);

  @override
  _Setting_CState createState() => _Setting_CState();
}

class _Setting_CState extends State<Setting_C> {
  bool _isC = true;

  @override
  Widget build(BuildContext context) {
    return Column( // C language
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
    );
  }
}