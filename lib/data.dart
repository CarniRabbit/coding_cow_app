/*
 * edit: 2024-06-15
 * 딩카 전역변수 저장 (앱 전반에 필요한 변수)
 * DB에서 select한 row
 * 기타 전역변수
 */

/*
 * 공통 규칙
 * 각 위젯마다 시작, 끝 주석으로 표기하기
 * 속성에 대한 간략한 설명 주석으로 넣기
 * 한글 작성시 항상 자간 -2 (letterSpacing: -2)
 * 다음 속성이 없더라도 무조건 반점 찍기
 * icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
 * 조건에 따라 화면이 바뀌는 경우 삼항연산자 사용할 것. 오히려 if, switch-case가 더 어려움.
 * 문제에 들어갈 코드와 힌트는 HTML 태그를 포함함. 예약어, 일부 단어에 파랑/빨강으로 highlight
 * HTML 태그를 포함한 코드, 힌트는 챗GPT를 통해 빠르게 생성할 수 있음.
 */


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<Problems> get_problems = [];

class Problems {
  final String ID;
  final int level;
  final int language;
  final String title;
  final String description;
  final String code;
  final String category;
  final String answer;
  final String hint;
  final String source;

  Problems({
    required this.ID,
    required this.level,
    required this.language,
    required this.title,
    required this.description,
    required this.code,
    required this.category,
    required this.answer,
    required this.hint,
    required this.source,
  });

  factory Problems.fromJson(Map<String, dynamic> json) {
    return Problems(
      ID: json["ID"],
      level: json["level"],
      language: json["language"],
      title: json["title"],
      description: json["description"],
      code: json["code"],
      category: json["category"],
      answer: json["answer"],
      hint: json["hint"],
      source: json["source"],
    );
  }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'ID': ID,
  //     'level': level,
  //     'language': language,
  //     'title': title,
  //     'description': description,
  //     'code': code,
  //     'category': category,
  //     'answer': answer,
  //     'hint': hint,
  //     'source': 'Baekjoon Online Judge(https://www.acmicpc.net/)'
  //   };
  // }
}

Future<List<Problems>> fromFirestore(String collection) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> _snapshot =
  await _firestore.collection(collection).get();

  get_problems =
  _snapshot.docs.map((e) => Problems.fromJson(e.data())).toList();

  return get_problems;
}

var hint = false; // hint 열람 여부
var problem_no = 0; // 문제 번호
var memo = "";