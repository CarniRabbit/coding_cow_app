import 'package:flutter/material.dart';

class Setting_Python extends StatefulWidget {
  const Setting_Python({Key? key}) : super(key: key);

  @override
  _Setting_PythonState createState() => _Setting_PythonState();
}

class _Setting_PythonState extends State<Setting_Python> {
  bool _isPython = false;

  @override
  Widget build(BuildContext context) {
    return Column( // C language
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
    );
  }
}