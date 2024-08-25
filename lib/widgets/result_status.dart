/*
 * Edit date: 2024-06-22
 * 딩카 결과 화면 - 정답/힌트정답/오답
*/

import 'package:coding_cow_app/data.dart';
import 'package:coding_cow_app/widgets/result_complete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class Result_Status extends StatefulWidget {
  final int status;
  final String uid;

  Result_Status(this.status, {required this.uid});

  @override
  _Result_StatusState createState() => _Result_StatusState();
}

class _Result_StatusState extends State<Result_Status> {
  @override
  void initState() {
    super.initState();
    //print('initState called');
    _updateStatsBasedOnResult();
  }

  Future<void> _updateStatsBasedOnResult() async {
    int solved = 1;
    int correct = (widget.status == 0 || widget.status == 1) ? 1 : 0;
    int incorrect = (widget.status == 2) ? 1 : 0;
    int hintUsed = (widget.status == 1) ? 1 : 0;
    int problemLevel = 1; // 문제의 난이도(예시로 1 사용, 실제로는 문제의 난이도 필요)

    try {
      print('updating user stats');
    await updateUserStats(
      uid: widget.uid,
      solvedProblems: solved,
      correctProblems: correct,
      incorrectProblems: incorrect,
      hintUsedProblems: hintUsed,
      problemLevel: problemLevel,
    );
    print('User stats updated successfully');
    setState(() {
      if (today_solved >= 10){
        complete_dialog(context);
      }
    });
  } catch (e) {
      print('Error updating user stats: $e');
    }
}

@override
Widget build(BuildContext context) {
  return Container( // code part
    alignment: FractionalOffset(0.5, 0.85),
    child: FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.72,
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // battery icon
              widget.status == 0 ? Image( // 힌트를 보지 않고 정답
                image: AssetImage('icon/full-battery.png'),
              ):
              widget.status == 1 ? Image( // 힌트를 보고 정답
                image: AssetImage('icon/battery.png'),
              ):
              Image( // 오답
                image: AssetImage('icon/low-battery.png'),
              ),
              SizedBox( // 아이콘<->글자 공백
                height: 20,
              ),

              // result text
              widget.status == 0 ? Text( // 힌트를 보지 않고 정답
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff45c9a5),
                    fontWeight: FontWeight.bold,
                  )
              ):
              widget.status == 1 ? Text( // 힌트를 보고 정답
                  'Nice one!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff8bc5c),
                    fontWeight: FontWeight.bold,
                  )
              ):
              Text( // 오답
                  'Keep it up!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfff86252),
                    fontWeight: FontWeight.bold,
                  )
              ),
            ],
          ),
        ),
        // background color
        decoration: widget.status == 0 ? BoxDecoration( // 힌트를 보지 않고 정답
          color: Color(0xffc3fded),
        ):
        widget.status == 1 ? BoxDecoration( // 힌트를 보고 정답
          color: Color(0xfff7deb6),
        ):
        BoxDecoration( // 오답
          color: Color(0xfffdc3c3),
        ),
      ),
    ),
  ); // end of code part
}
}
