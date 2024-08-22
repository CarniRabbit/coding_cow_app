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
import 'package:firebase_auth/firebase_auth.dart';
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



class UserData {
  final String uid;
  final String email;
  final String league;
  final Timestamp createdAt;
  final Timestamp lastLoginAt;
  final bool isAttend;
  final int level;
  final int problemsSolved;
  final int languageSetting;
  final int bracketSetting;
  final int attendanceDays;

  UserData({
    required this.uid,
    required this.email,
    required this.league,
    required this.createdAt,
    required this.lastLoginAt,
    this.isAttend = false,
    this.level = 1,
    this.problemsSolved = 0,
    this.languageSetting = 1,
    this.bracketSetting = 1,
    this.attendanceDays = 0,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'],
      email: json['email'],
      league: json['league'],
      createdAt: json['createdAt'],
      lastLoginAt: json['lastLoginAt'],
      isAttend: json['isAttend'] ?? false,
      level: json['level'] ?? 1,
      problemsSolved: json['problemsSolved'] ?? 0,
      languageSetting: json['languageSetting'] ?? 1,
      bracketSetting: json['bracketSetting'] ?? 1,
      attendanceDays: json['attendanceDays'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'createdAt': createdAt,
      'lastLoginAt': lastLoginAt,
      'isAttend': isAttend,
      'level': level,
      'problemsSolved': problemsSolved,
      'languageSetting': languageSetting,
      'bracketSetting': bracketSetting,
      'attendanceDays': attendanceDays,
      'league': league,
    };
  }
}

class UserStats {
  final String uid;
  final int totalProblemsSolved;
  final int correctProblemsCount;
  final int incorrectProblemsCount;
  final int hintUsedProblemsCount;
  final double averageProblemLevel;
  final Timestamp lastUpdated;

  UserStats({
    required this.uid,
    this.totalProblemsSolved = 0,
    this.correctProblemsCount = 0,
    this.incorrectProblemsCount = 0,
    this.hintUsedProblemsCount = 0,
    this.averageProblemLevel = 0.0,
    required this.lastUpdated,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      uid: json['uid'],
      totalProblemsSolved: json['totalProblemsSolved'] ?? 0,
      correctProblemsCount: json['correctProblemsCount'] ?? 0,
      incorrectProblemsCount: json['incorrectProblemsCount'] ?? 0,
      hintUsedProblemsCount: json['hintUsedProblemsCount'] ?? 0,
      averageProblemLevel: json['averageProblemLevel']?.toDouble() ?? 0.0,
      lastUpdated: json['lastUpdated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'totalProblemsSolved': totalProblemsSolved,
      'correctProblemsCount': correctProblemsCount,
      'incorrectProblemsCount': incorrectProblemsCount,
      'hintUsedProblemsCount': hintUsedProblemsCount,
      'averageProblemLevel': averageProblemLevel,
      'lastUpdated': lastUpdated,
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

Future<void> saveUserStats(UserStats userStats) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection('UserStats').doc(userStats.uid).set(
    userStats.toJson(),
    SetOptions(merge: true),
  );
}

Future<void> updateUserStats({
  required String uid,
  int solvedProblems = 0,
  int correctProblems = 0,
  int incorrectProblems = 0,
  int hintUsedProblems = 0,
  int? problemLevel,
}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference docRef = firestore.collection('UserStats').doc(uid);

  try {
    await firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);

      if (snapshot.exists) {

        UserStats currentStats = UserStats.fromJson(
            snapshot.data() as Map<String, dynamic>);

        int updatedSolvedProblems = solvedProblems +
            currentStats.totalProblemsSolved;
        int updatedCorrectProblems = correctProblems +
            currentStats.correctProblemsCount;
        int updatedIncorrectProblems = incorrectProblems +
            currentStats.incorrectProblemsCount;
        int updatedHintUsedProblems = hintUsedProblems +
            currentStats.hintUsedProblemsCount;

        double updatedProblemLevel = currentStats.averageProblemLevel;
        if (solvedProblems > 0 && problemLevel != null) {
          updatedProblemLevel = ((currentStats.averageProblemLevel *
              currentStats.totalProblemsSolved) + problemLevel) /
              updatedSolvedProblems;
        }

        transaction.update(docRef, {
          'totalProblemsSolved': updatedSolvedProblems,
          'correctProblemsCount': updatedCorrectProblems,
          'incorrectProblemsCount': updatedIncorrectProblems,
          'hintUsedProblemsCount': updatedHintUsedProblems,
          'averageProblemLevel': updatedProblemLevel,
          'lastUpdated': Timestamp.now(),
        });
      } else {
        // Document가 존재하지 않는 경우 새로 생성
        transaction.set(docRef, {
          'uid': uid,
          'totalProblemsSolved': solvedProblems,
          'correctProblemsCount': correctProblems,
          'incorrectProblemsCount': incorrectProblems,
          'hintUsedProblemsCount': hintUsedProblems,
          'averageProblemLevel': problemLevel?.toDouble() ?? 0.0,
          'lastUpdated': Timestamp.now(),
        });
      }
    });
  } catch (e) {
    print('error updating user stats: $e');
  }
}

Future<void> addIncorrectProblem(String problemId) async { // Keep it up 일 경우 Incorrects DB에 추가
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    throw Exception("No user is currently logged in.");
  }

  String uid = currentUser.uid; // 현재 로그인한 유저의 UID
  String docId = '${uid}_${problemId}';
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
        'uid': uid,
        'problemId': problemId,
        'count': 1,
        'timestamp': Timestamp.now(),
      });
    }
  });
}