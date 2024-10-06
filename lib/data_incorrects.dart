import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'data_problems.dart';

class IncorrectProblems {
  final String ID;
  final String email;
  final int count;
  final Timestamp lastSolved;
  final Timestamp reviewDate;
  final Timestamp timestamp;
  final int cycle;

  IncorrectProblems({
    required this.ID,
    required this.email,
    required this.count,
    required this.lastSolved,
    required this.reviewDate,
    required this.timestamp,
    required this.cycle,
  });

  factory IncorrectProblems.fromJson(Map<String, dynamic> json) {
    return IncorrectProblems(
      ID: json["problemId"],
      email: json["email"],
      count: json["count"],
      lastSolved: json["lastSolved"],
      reviewDate: json["reviewDate"],
      timestamp: json["timestamp"],
      cycle: json["cycle"],
    );
  }
}

Future<List<Problems>> incorrectsFromFirestore(String? email) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 여러번 업데이트 되어 list의 요소가 중복되는 것을 방지하기 위해 전부 초기화
  get_incorrects_ID = [];
  get_incorrects_date = [];
  get_problems = [];

  // 문제 1~136번까지 모두 Incorrects에 있는지 순차적으로 탐색하는 for문
  QuerySnapshot<Map<String, dynamic>> _snapshot =
  await _firestore.collection('incorrectProblems').where('email', isEqualTo: auth.currentUser?.email).get();

  List<IncorrectProblems> get_incorrects =
  await _snapshot.docs.map((e) => IncorrectProblems.fromJson(e.data())).toList();

  get_incorrects.forEach((incorrect) {
    get_incorrects_ID.add(incorrect.ID);
    get_incorrects_date.add(incorrect.reviewDate.toDate());
  });

  // print(get_incorrects_ID);
  // print(get_incorrects_date);

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
      // DateTime lastSolved = docSnapshot.get('lastSolved');

      // doc가 존재하면 틀린 횟수 증가
      // count가 2 이상인 문제를 틀리면 다시 1일 뒤에 복습으로 변경
      transaction.update(docRef, {'count': currentCount + 1});
    } else {
      // doc가 존재하지 않는다면(처음 틀린 문제) 새로 생성하고 count를 1로 설정
      transaction.set(docRef, {
        'email': auth.currentUser?.email,
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

    new_cycle = 1;
  });
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