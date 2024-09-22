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
List<String> get_incorrects_ID = [];
String get_nickname = '';
int get_level = 0;
int get_restEXP = 0;
String current_email = '';
int new_cycle = 0;
final FirebaseAuth auth = FirebaseAuth.instance;

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

Future<List<Problems>> problemsFromFirestore() async { // Problems DB의 전체 문서 조회
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> _snapshot =
  await _firestore.collection('Problems').get();

  get_problems =
  await _snapshot.docs.map((e) => Problems.fromJson(e.data())).toList();

  // print(get_problems);

  return get_problems;
}

int mode = 0; // 0: 오늘의 문제, 1: 오답 문제
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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> docRef =
  _firestore.collection('users').doc(email);

  DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
  get_nickname = docSnapshot.data()?['nickname'];
  get_level = docSnapshot.data()?['level'];
  get_restEXP = docSnapshot.data()?['restEXP'];

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

class TodayProblem {
  final String uid;
  final String problemId;
  final bool isCorrect;
  final bool hintUsed;
  final int level;
  final Timestamp timestamp;

  TodayProblem({
    required this.uid,
    required this.problemId,
    required this.isCorrect,
    required this.hintUsed,
    required this.level,
    required this.timestamp,
  });

  factory TodayProblem.fromJson(Map<String, dynamic> json) {
    return TodayProblem(
      uid: json['uid'],
      problemId: json['problemId'],
      isCorrect: json['isCorrect'],
      hintUsed: json['hintUsed'],
      level: json['level'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'problemId': problemId,
      'isCorrect': isCorrect,
      'hintUsed': hintUsed,
      'level': level,
      'timestamp': timestamp,
    };
  }
}

Future<void> checkAttendance(String? email) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> docRef =
  _firestore.collection('users').doc(email);

  DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();
  print(docSnapshot.data()?['email']);

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

Future<void> addIncorrectProblem(String problemId) async {
  // Keep it up 일 경우 Incorrects DB에 추가
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    throw Exception("No user is currently logged in.");
  }

  String docId = '${auth.currentUser?.email}_${problemId}'; // 문서 제목
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('incorrectProblems')
      .doc(docId);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot docSnapshot = await transaction.get(docRef);
    if (docSnapshot.exists) {
      int currentCount = docSnapshot.get('count');
      int cycle = docSnapshot.get('cycle');
      new_cycle = 0;
      // DateTime lastSolved = docSnapshot.get('lastSolved');

      // doc가 존재하면 틀린 횟수 증가
      transaction.update(docRef, {'count': currentCount + 1});
    } else {
      // doc가 존재하지 않는다면(처음 틀린 문제) 새로 생성하고 count를 1로 설정
      transaction.set(docRef, {
        'userId': auth.currentUser?.email,
        'problemId': problemId,
        'count': 1,
        'timestamp': DateTime.now(),
      });
    }

    transaction.update(docRef, {
      'cycle': 1,
      'lastSolved': DateTime.now(),
      'reviewDate': DateTime.now().add(Duration(days: 1)),
    });
  });
}

Future<List<Problems>> incorrectsFromFirestore(String? email) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // 여러번 업데이트 되어 list의 요소가 중복되는 것을 방지하기 위해 전부 초기화
  get_incorrects_ID = [];
  get_problems = [];
  String problemID = "";

  // 문제 1~136번까지 모두 Incorrects에 있는지 순차적으로 탐색하는 for문
  for(int i = 1; i <= 136; i++) { // 나중에 조건 변경하기
    // 문제 ID 생성 조건문
    if (i < 10) {
      problemID = 'ex000${i}-1';
    } else if (i < 100) {
      problemID = 'ex00${i}-1';
    } else if (i < 1000) {
      problemID = 'ex0${i}-1';
    } else {
      problemID = 'ex${i}-1';
    }

    // 현재 계정과 문제 번호를 기본키로서 사용
    DocumentReference<Map<String, dynamic>> docRef =
    await _firestore.collection('incorrectProblems').doc('${email}_${problemID}');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();

    if (docSnapshot.data() != null) { // 해당 계정에 현재 문제ID와 일치하는 오답이 존재할 때
      get_incorrects_ID.add(problemID); // 해당 계정의 오답 문제ID를 저장함
    }
  }

  for (int i = 0; i < get_incorrects_ID.length; i++) {
    // 해당 계정의 오답 문제ID를 통해 Problems DB에서 문제 정보 조회
    DocumentReference<Map<String, dynamic>> docRef =
    await _firestore.collection('Problems').doc(get_incorrects_ID[i]);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await docRef.get();

    // Problems incorrect = Problems.fromJson(docSnapshot.data()!);
    // get_problems에 해당 계정의 오답 문제 정보 저장
    get_problems.add(Problems.fromJson(docSnapshot.data()!));
  }

  return get_problems;
}

// 오답 문제 삭제 함수
Future<void> deleteIncorrectProblem(String? email, String problemID) async {
  // 오답 노트에서 문제를 맞췄을 경우, 매개변수로 받은 이메일과 문제ID로 삭제할 문제 지정
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> docRef =
  await firestore.collection('incorrectProblems').doc('${email}_${problemID}');

  // 해당 오답 문제 삭제
  docRef.delete();
}

Future<void> addTodayProblem(TodayProblem todayProblem) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection('todayProblems').doc('${todayProblem.uid}_${todayProblem.problemId}').set(todayProblem.toJson());
}

Future<void> updateUserTotalScore(String uid) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference docRef = firestore.collection('UserStats').doc(uid);

  try {
    await firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);

      if (snapshot.exists) {
        UserStats currentStats = UserStats.fromJson(
            snapshot.data() as Map<String, dynamic>);

        int totalScore = (currentStats.averageProblemLevel / 16 * 10).floor() *
            (currentStats.correctProblemsCount +
                currentStats.hintUsedProblemsCount) ~/ 2;

        transaction.update(docRef, {
          'totalScore': totalScore,
          'lastUpdated': Timestamp.now(),
        });
      } else {
        print('UserStats document does not exist.');
      }
    });
  } catch (e) {
    print('Error updating total score: $e');
  }
}
