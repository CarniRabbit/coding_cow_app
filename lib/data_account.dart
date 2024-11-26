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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_problems.dart';
import 'data_global.dart';

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
  final int restEXP;
  final String nickname;

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
    required this.restEXP,
    required this.nickname,
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
      languageSetting: json['languageSetting'] ?? 2,
      bracketSetting: json['bracketSetting'] ?? 1,
      attendanceDays: json['attendanceDays'] ?? 0,
      restEXP: json['restEXP'],
      nickname: json['nickname'] ?? '익명',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'restEXP': restEXP,
      'nickname': nickname,
    };
  }
}

Future<(String, int, int)> getUserInfo(String? email) async {
  problem_no = 0;
  get_problems = [];
  get_today_problems_ID = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> docRef =
  _firestore.collection('users').doc(email);

  DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
  get_nickname = docSnapshot.data()?['nickname'];
  get_level = docSnapshot.data()?['level'];
  get_restEXP = docSnapshot.data()?['restEXP'];

  // 오늘의 문제 DB 생성 및 로드 (isAttend가 false일 때)
  if (!docSnapshot.data()?['isAttend']) { // 오늘 처음 접속할 경우
    await createTodayProblem(get_level, email);
  }

  // 현재 계정에 맞는 오늘의 문제 조회
  QuerySnapshot<Map<String, dynamic>> _snapshot =
  await _firestore.collection('todayProblems').where('email', isEqualTo: auth.currentUser?.email).get();

  // 리스트로 변환 후 저장
  List<TodayProblems> get_today_problems =
  await _snapshot.docs.map((e) => TodayProblems.fromJson(e.data())).toList();

  if (!hasTodayProblems) {
    // 오늘의 문제의 ID를 따로 저장
    get_today_problems.forEach((today_problem) {
      get_today_problems_ID.add(today_problem.ID);
    });

    hasTodayProblems = true;
  }

  get_today_problems_ID.shuffle();

  await handleDailyAttendance(email);

  return (get_nickname, get_level, get_restEXP);
}

class UserStats {
  final String uid;
  final int totalProblemsSolved;
  final int correctProblemsCount;
  final int incorrectProblemsCount;
  final int hintUsedProblemsCount;
  final double averageProblemLevel;
  final Timestamp lastUpdated;
  final int totalScore;

  UserStats({
    required this.uid,
    this.totalProblemsSolved = 0,
    this.correctProblemsCount = 0,
    this.incorrectProblemsCount = 0,
    this.hintUsedProblemsCount = 0,
    this.averageProblemLevel = 0.0,
    required this.lastUpdated,
    this.totalScore = 0,
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
      totalScore: json['totalScore'] ?? 0,
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
      'totalScore': totalScore,
    };
  }
}

Future<void> checkAttendance(String? email) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> docRef =
  _firestore.collection('users').doc(email);

  DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
  // print(docSnapshot.data()?['email']);

  if (docSnapshot.exists) {
    bool isAttend = docSnapshot.data()?['isAttend'] ?? false;

    if (!isAttend) {
      await docRef.update({
        'todaySolved': 0,
        'isAttend': true,
        'lastLoginAt': Timestamp.now(),
      });
    }
  } else {
    print('Document does not exist');
  }
}

Future<void> handleDailyAttendance(String? email) async {
  await checkAttendance(email);
}

void onAppStart(String uid) async {
  // await handleDailyAttendance(uid);
}

Future<void> saveUserStats(UserStats userStats) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore.collection('UserStats').doc(userStats.uid).set(
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
      int updatedSolvedProblems, updatedCorrectProblems, updatedIncorrectProblems, updatedHintUsedProblems;
      double updatedProblemLevel;
      int updatedTotalScore;

      if (snapshot.exists) {
        UserStats currentStats = UserStats.fromJson(snapshot.data() as Map<String, dynamic>);
        updatedSolvedProblems = solvedProblems + currentStats.totalProblemsSolved;
        updatedCorrectProblems = correctProblems + currentStats.correctProblemsCount;
        updatedIncorrectProblems = incorrectProblems + currentStats.incorrectProblemsCount;
        updatedHintUsedProblems = hintUsedProblems + currentStats.hintUsedProblemsCount;

        updatedProblemLevel = currentStats.averageProblemLevel;
        if (solvedProblems > 0 && problemLevel != null) {
          updatedProblemLevel = ((currentStats.averageProblemLevel * currentStats.totalProblemsSolved) + problemLevel) / updatedSolvedProblems;
        }

        updatedTotalScore = ((updatedProblemLevel / 16) * 10).floor() * (updatedCorrectProblems + updatedHintUsedProblems) ~/ 2;

        // 레벨이 16 이하인 경우 기본 점수 추가
        if (updatedProblemLevel <= 16) {
          updatedTotalScore += (updatedCorrectProblems + updatedHintUsedProblems) * 2; // 가중치 점수
        }

        transaction.update(docRef, {
          'totalProblemsSolved': updatedSolvedProblems,
          'correctProblemsCount': updatedCorrectProblems,
          'incorrectProblemsCount': updatedIncorrectProblems,
          'hintUsedProblemsCount': updatedHintUsedProblems,
          'averageProblemLevel': updatedProblemLevel,
          'totalScore': updatedTotalScore,
          'lastUpdated': Timestamp.now(),
        });
      } else {
        // Document가 존재하지 않는 경우 새로 생성
        updatedSolvedProblems = solvedProblems;
        updatedCorrectProblems = correctProblems;
        updatedIncorrectProblems = incorrectProblems;
        updatedHintUsedProblems = hintUsedProblems;
        updatedProblemLevel = problemLevel?.toDouble() ?? 0.0;
        updatedTotalScore = (updatedCorrectProblems + updatedHintUsedProblems) * 2; // 기본 점수

        transaction.set(docRef, {
          'uid': uid,
          'totalProblemsSolved': updatedSolvedProblems,
          'correctProblemsCount': updatedCorrectProblems,
          'incorrectProblemsCount': updatedIncorrectProblems,
          'hintUsedProblemsCount': updatedHintUsedProblems,
          'averageProblemLevel': updatedProblemLevel,
          'totalScore': updatedTotalScore,
          'lastUpdated': Timestamp.now(),
        });
      }
      print('UserStats와 totalScore가 업데이트되었습니다.');
    });
  } catch (e) {
    print('Error updating user stats and total score: $e');
  }
}