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
  final String input;
  final String output;

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

Future<List<Problems>> fromFirestore(String collection) async { // 매개변수에 맞는 collection의 내용 조회
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> _snapshot =
  await _firestore.collection(collection).get();

  get_problems =
  await _snapshot.docs.map((e) => Problems.fromJson(e.data())).toList();

  // print(get_problems);

  return get_problems;
}

var hint = false; // hint 열람 여부
var problem_no = 0; // 문제 번호
var memo = ""; // 문제 풀이를 위한 메모
var today_solved = 0; // 오늘의 푼 문제 수
var today_progress = 0.0; // 오늘의 푼 문제 비율 (푼 문제 수/10)

Future<void> addIncorrectProblem(String problemId) async { // Keep it up 일 경우 Incorrects DB에 추가
  const String tempUserId = "user1";//사용자 ID 임시 설정
  String docId = '${tempUserId}_${problemId}';
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('incorrectProblems')
      .doc(docId);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot docSnapshot = await transaction.get(docRef);

    if (docSnapshot.exists) {
      int currentCount = docSnapshot.get('count');
      // doc가 존재하면 틀린 횟수 증가
      transaction.update(docRef, {'count': currentCount + 1});
    } else {
      // doc가 존재하지 않으면 새로 생성하고 count를 1로 설정
      transaction.set(docRef, {
        'userId': tempUserId,
        'problemId': problemId,
        'count': 1,
        'timestamp': Timestamp.now(),
      });
    }
  });
}

class UserData {
  final String uid;
  final String email;
  final Timestamp createdAt;
  final Timestamp lastLoginAt;
  final bool isAttend;

  UserData({
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.lastLoginAt,
    this.isAttend = false,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'],
      email: json['email'],
      createdAt: json['createdAt'],
      lastLoginAt: json['lastLoginAt'],
      isAttend: json['isAttend'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'createdAt': createdAt,
      'lastLoginAt': lastLoginAt,
      'isAttend': isAttend,
    };
  }
}

Future<void> checkAttendance(String uid) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> docRef =
  _firestore.collection('users').doc(uid);

  DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();

  if (docSnapshot.exists) {
    bool isAttend = docSnapshot.data()?['isAttend'] ?? false;

    if (!isAttend) {
      await docRef.update({
        'todaySolved': 0,
        'isAttend': true,
        'lastLoginAt': Timestamp.now(),});
    }
  } else {
    print('Document does not exist');
  }
}


Future<void> handleDailyAttendance(String uid) async {
  await checkAttendance(uid);
}

void onAppStart(String uid) async {
  await handleDailyAttendance(uid);
}