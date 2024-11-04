/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 정답 입력창
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/data_account.dart';
import 'package:coding_cow_app/result.dart';
import 'package:coding_cow_app/widgets/main_measure.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/data_incorrects.dart';

void answer_input_dialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      final _answerEditController = TextEditingController();

      return Dialog( // answer input dialogue
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.help_outline),
                color: Color(0xff2355DA),
                iconSize: 50,
                tooltip: "연산자와 피연산자는 띄어쓰기가 불가합니다.\n아래 예시를 참고하여 정답을 작성해주세요.\nex)\nresult = a * b / c (X)\nresult=a*b/c (O)",
                onPressed: () {

                },
              ),
              Text(
                '답안 작성 예시',
                style: TextStyle(
                  color: Color(0xff2355DA),
                  letterSpacing: -2,
                ),
              ),
              TextField( // input
                controller: _answerEditController,
                decoration: InputDecoration(
                  hintText: '정답을 입력해주세요',
                ),
              ),
              TextButton(
                  onPressed: () async { // press event (확인)
                    // 입력한 값 == Problem DB의 현재 문제의 정답 여부 판별
                    // mode 0 (오늘의 문제)
                    bool isCorrect = false;
                    bool hintUsed = false;
                    int level = get_problems[problem_no].level;
                    String problemId = get_problems[problem_no].ID;

                    var text = _answerEditController.text; // 입력한 값
                    int status = 0;

                    if (text.replaceAll(RegExp('\\s'), "") == get_problems[problem_no].answer.replaceAll(RegExp('\\s'), "")) {
                      // hint를 보지 않고 정답을 맞췄을 때
                      if (!hint) {
                        status = 0;
                        isCorrect = true;
                        hintUsed = false;
                      }
                      // hint를 보고 정답을 맞췄을 때
                      else {
                        status = 1;
                        isCorrect = true;
                        hintUsed = true;
                      }

                      if (mode == 1) { // 오답노트일 때
                        // 맞춘 문제를 Incorrects DB에서 삭제
                        deleteIncorrectProblem(auth.currentUser?.email, get_problems[problem_no].ID);
                        // 프론트엔드의 오답ID, 문제 배열에서 삭제
                        get_problems.removeAt(problem_no);
                        get_incorrects_ID.removeAt(problem_no);
                      } else { // 오늘의 문제일 때
                        await incorrectsFromFirestore(auth.currentUser?.email);

                        get_incorrects_ID.forEach((incorrect) {
                          // 오답노트에 같은 문제가 존재할 경우 (현재 문제 ID == 오답노트의 문제 ID 순차탐색)
                          if (get_problems[problem_no].ID == incorrect) {
                            String docId = '${auth.currentUser?.email}_${incorrect}';// 문서 제목
                            DocumentReference docRef = FirebaseFirestore.instance
                                .collection('incorrectProblems')
                                .doc(docId);
                            // cycle = 1일때 3일 뒤에 복습 -> cycle = 3일때 5일 뒤...
                            FirebaseFirestore.instance.runTransaction((transaction) async {
                              DocumentSnapshot docSnapshot = await transaction.get(docRef);
                              if (docSnapshot.exists) {
                                int cycle = docSnapshot.get('cycle');
                                switch(cycle) {
                                  case 1:
                                    new_cycle = 3;
                                    break;
                                  case 3:
                                    new_cycle = 5;
                                    break;
                                  case 5:
                                    new_cycle = 7;
                                    break;
                                  case 7:
                                    new_cycle = 14;
                                    break;
                                  case 14:
                                    new_cycle = 21;
                                    break;
                                  case 21:
                                    new_cycle = 30;
                                    break;
                                  case 30:
                                    new_cycle = 60;
                                    break;
                                  case 60:
                                    new_cycle = 90;
                                    break;
                                  case 90:
                                    new_cycle = 120;
                                    break;
                                  case 120:
                                    new_cycle = 150;
                                    break;
                                  case 150:
                                    new_cycle = 180;
                                }

                                // reviewDate 속성은 lastSolved+복습주기
                                // count가 2 이상인 문제를 틀리면 다시 1일 뒤에 복습으로 변경
                                transaction.update(docRef, {
                                  'cycle': new_cycle,
                                  'lastSolved': DateTime.now(),
                                  'reviewDate': DateTime.now().add(
                                      Duration(days: new_cycle)
                                  ),
                                });
                              } else {
                                // doc가 존재하지 않는다면(처음 틀린 문제) 새로 생성하고 count를 1로 설정
                                transaction.set(docRef, {
                                  'email': auth.currentUser?.email,
                                  'problemId': problemId,
                                  'count': 1,
                                  'timestamp': DateTime.now(),
                                  'lastSolved': DateTime.now(),
                                  'reviewDate': DateTime.now().add(Duration(days: 1)),
                                  'cycle': 1,
                                });
                              }
                            });

                            docRef = FirebaseFirestore.instance
                                .collection('users')
                                .doc(auth.currentUser?.email);
                            // cycle = 1일때 3일 뒤에 복습 -> cycle = 3일때 5일 뒤...
                            FirebaseFirestore.instance.runTransaction((transaction) async {
                              DocumentSnapshot docSnapshot = await transaction.get(docRef);
                              if (docSnapshot.exists) {
                                get_restEXP = docSnapshot.get('restEXP');

                                transaction.update(docRef, {
                                  'restEXP': today_problem_count - today_solved,
                                });
                              } else {
                                // doc가 존재하지 않는다면(처음 틀린 문제) 새로 생성하고 count를 1로 설정
                                transaction.set(docRef, {
                                  'email': auth.currentUser?.email,
                                  'problemId': problemId,
                                  'count': 1,
                                  'timestamp': DateTime.now(),
                                  'lastSolved': DateTime.now(),
                                  'reviewDate': DateTime.now().add(Duration(days: 1)),
                                  'cycle': 1,
                                });
                              }
                            });
                          }
                        });

                        // reviewDate 속성은 lastSolved+복습주기
                      }

                      today_solved++;
                      today_progress = today_solved / today_problem_count;
                    }

                    // 답을 틀렸을 때
                    else {
                      status = 2;
                      await addIncorrectProblem(get_problems[problem_no].ID); // 답을 틀렸을 때 Incorrect DB에 저장
                    }

                    // 결과 화면으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Result_Page(status, uid: getCurrentUserId())),
                    );
                  }, 
                  child: Text(
                    '입력',
                    style: TextStyle(
                      color: Color(0xff2355DA),
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ],
          ),
          padding: EdgeInsets.all(10), // padding 상하좌우 10px
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
      ); // end of answer input dialog
    },
  );
}