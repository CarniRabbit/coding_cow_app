/*
 * edit: 2024-08-03
 * 딩카 문제 화면 - 메모 팝업
 */

import 'package:coding_cow_app/data.dart';
import 'package:flutter/material.dart';

void memo_dialog(context) {
  final _memoEditController = TextEditingController(
    text: memo, // 메모 내용 유지
  );

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Color(0xffeafceb).withOpacity(0.5), // 배경 반투명
        shape: RoundedRectangleBorder( // 모서리 둥글게 X
          borderRadius: BorderRadius.zero,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffeafceb).withOpacity(0.5),
            borderRadius: BorderRadius.zero,
          ),
          child: TextField(
            onChanged: (text) { // 내용이 바뀔때마다 memo 전역변수에 저장
              memo = text;
              // print(memo);
            },
            controller: _memoEditController,
            maxLines: null, // 입력 줄수 제한X
            expands: true, // dialog 높이에 맞춰 늘어나게 함
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              // filled: true,
              hintText: "문제 풀이에 필요한 내용을 적어둘 수 있어요.", // placeholder (입력창 설명문)
              hintMaxLines: 2, // hintText는 두줄까지만 표시하고 세줄부터는 (...)으로 생략
              border: InputBorder.none, // TextField의 아래 border 제거
              fillColor: Colors.transparent, // 투명하게
            ),
          ),
        ),
      );
    },
  );
}