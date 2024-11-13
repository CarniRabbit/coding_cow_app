/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 정답 입력창
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/result.dart';
import 'package:coding_cow_app/widgets/main_measure.dart';
import 'package:coding_cow_app/widgets/transition_route_state.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/data_incorrects.dart';
import 'move_middle_to_circle_transition_route.dart';
import 'popup_animation.dart';

void answer_input_dialog(context) {
  showDialog(
    context: context,
    builder: (_) => FunkyOverlay(),
  );
}