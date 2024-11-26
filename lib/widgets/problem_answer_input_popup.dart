/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 정답 입력창
 */


import 'package:flutter/material.dart';
import 'popup_animation.dart';

void answer_input_dialog(context) {
  showDialog(
    context: context,
    builder: (_) => FunkyOverlay(),
  );
}