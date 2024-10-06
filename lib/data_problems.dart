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

import 'dart:core';
import 'package:coding_cow_app/data_incorrects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_global.dart';

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
  final String input;
  final String output;
  final String solution;

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
    required this.input,
    required this.output,
    required this.solution,
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
      input: json["input"],
      output: json["output"],
      solution: json["solution"],
    );
  }
}

Future<List<Problems>> problemsFromFirestore() async { // Problems DB에서 오늘의 문제 조회
  get_today_problems_ID = [];
  get_problems = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> _snapshot =
  await _firestore.collection('todayProblems').where('email', isEqualTo: auth.currentUser?.email).get();

  List<TodayProblems> get_today_problems =
  await _snapshot.docs.map((e) => TodayProblems.fromJson(e.data())).toList();

  get_today_problems.forEach((today_problem) {
    get_today_problems_ID.add(today_problem.ID);
  });

  for (int i = 0; i<get_today_problems_ID.length; i++) {
    QuerySnapshot<Map<String, dynamic>> docSnapshot =
    await _firestore.collection('Problems').where('ID', isEqualTo: get_today_problems_ID[i]).get();

    Problems problem =
    await docSnapshot.docs.map((e) => Problems.fromJson(e.data())).toList()[0];

    get_problems.add(problem);
  }

  get_problems.shuffle();

  return get_problems;
}

Future<void> createTodayProblem(int userLevel, String? email) async {
  get_problems = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // DocumentReference<Map<String, dynamic>> docRef =
  // firestore.collection('incorrectProblems').doc(email);

  // todayProblems에 10문제 쓰기
  await incorrectsFromFirestore(email);

  for (int i = 0; i < get_problems.length; i++) {
    // incorrectsProblems에서 계정이 일치하는 문제 중 reviewDate == Now() 인 문제들을 todayProblems DB에 추가
    if (get_incorrects_date[i].year == DateTime.now().year &&
        get_incorrects_date[i].month == DateTime.now().month &&
        get_incorrects_date[i].day == DateTime.now().day) {
      firestore.collection('todayProblems').doc('${auth.currentUser?.email}_${get_incorrects_ID[i]}').set({
        'ID': get_incorrects_ID[i],
        'email': auth.currentUser?.email,
      });

      today_review++;
    }
  }

  // 레벨이 9이하일 경우 레벨 1인 문제 랜덤 추가한 뒤 2인 문제 추가
  if(get_level <= 9) {
    // 레벨 1인 문제 추가
    QuerySnapshot<Map<String, dynamic>> _snapshot =
    await firestore.collection('Problems')
        .where('level', isEqualTo: 1)
        .get(); // 레벨1인 문제 select

    List<Problems> current_level_problems =
    await _snapshot.docs.map((e) => Problems.fromJson(e.data()))
        .toList(); // List로 변환
    current_level_problems.shuffle(); // 문제 순서 셔플

    // 하루에 풀어야할 문제수(현재 10)에서 오늘 복습해야할 문제수를 뺀만큼 반복한다.
    for (int i = 0; i < today_problem_count - today_review; i++) {
      firestore.collection('todayProblems').doc(
          '${auth.currentUser?.email}_${current_level_problems[i].ID}').set({
        'ID': current_level_problems[i].ID,
        'email': auth.currentUser?.email,
      });

      today_current_level++;
    }

    // 레벨 2인 문제 추가
    _snapshot =
    await firestore.collection('Problems').where('level', isEqualTo: 2).get(); // 레벨1인 문제 select

    List<Problems> next_level_problems =
    await _snapshot.docs.map((e) => Problems.fromJson(e.data())).toList(); // List로 변환
    next_level_problems.shuffle(); // 문제 순서 셔플

    // 만약 하루에 풀어야할 문제수-오늘 복습해야할 문제수가 0보다 크다면 반복문을 실행함. (= 레벨2 문제도 추가할 공간이 남았다는 의미)
    for (int i = 0; i < today_problem_count - today_review - today_current_level; i++) {
      firestore.collection('todayProblems').doc(
          '${auth.currentUser?.email}_${next_level_problems[i].ID}').set({
        'ID': next_level_problems[i].ID,
        'email': auth.currentUser?.email,
      });

      today_next_level++;
    }

  } else { // 레벨 10부터는 현재레벨/5, 현재레벨/5-1, 현재레벨/5+1 문제 추가
    // 현재레벨/5
    QuerySnapshot<Map<String, dynamic>> _snapshot =
    await firestore.collection('Problems')
        .where('level', isEqualTo: get_level~/5)
        .get(); // 레벨1인 문제 select

    List<Problems> current_level_problems =
    await _snapshot.docs.map((e) => Problems.fromJson(e.data()))
        .toList(); // List로 변환
    current_level_problems.shuffle(); // 문제 순서 셔플

    // 하루에 풀어야할 문제수(현재 10)에서 오늘 복습해야할 문제수를 뺀만큼 반복한다.
    for (int i = 0; i < today_problem_count - today_review; i++) {
      firestore.collection('todayProblems').doc('${auth.currentUser?.email}_${current_level_problems[i].ID}').set({
        'ID': current_level_problems[i].ID,
        'email': auth.currentUser?.email,
      });

      today_current_level++;
    }

    // 현재레벨/5-1
    _snapshot =
    await firestore.collection('Problems').where('level', isEqualTo: get_level~/5+1).get(); // 레벨1인 문제 select

    List<Problems> prev_level_problems =
    await _snapshot.docs.map((e) => Problems.fromJson(e.data())).toList(); // List로 변환
    prev_level_problems.shuffle(); // 문제 순서 셔플

    // 만약 하루에 풀어야할 문제수-오늘 복습해야할 문제수-현재 레벨의 문제수가 0보다 크다면 반복문을 실행함.
    for (int i = 0; i < today_problem_count - today_review - today_current_level; i++) {
      firestore.collection('todayProblems').doc(
          '${auth.currentUser?.email}_${prev_level_problems[i].ID}').set({
        'ID': prev_level_problems[i].ID,
        'email': auth.currentUser?.email,
      });

      today_prev_level++;
    }

    // 현재레벨/5+1
    _snapshot =
    await firestore.collection('Problems').where('level', isEqualTo: get_level~/5+1).get(); // 레벨1인 문제 select

    List<Problems> next_level_problems =
    await _snapshot.docs.map((e) => Problems.fromJson(e.data())).toList(); // List로 변환
    next_level_problems.shuffle(); // 문제 순서 셔플

    // 만약 하루에 풀어야할 문제수-오늘 복습해야할 문제수-현재 레벨의 문제수-이전 레벨의 문제수가 0보다 크다면 반복문을 실행함.
    for (int i = 0; i < today_problem_count - today_review - today_current_level - today_prev_level; i++) {
      firestore.collection('todayProblems').doc(
          '${auth.currentUser?.email}_${next_level_problems[i].ID}').set({
        'ID': next_level_problems[i].ID,
        'email': auth.currentUser?.email,
      });

      today_next_level++;
    }
  }
}

class TodayProblems {
  final String ID;
  final String email;

  TodayProblems({
    required this.ID,
    required this.email,
  });

  factory TodayProblems.fromJson(Map<String, dynamic> json) {
    return TodayProblems(
      ID: json['ID'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'email': email,
    };
  }
}