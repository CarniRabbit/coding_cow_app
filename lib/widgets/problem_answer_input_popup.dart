/*
 * edit: 2024-06-08
 * 딩카 문제 화면 - 정답 입력창
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/data_account.dart';
import 'package:coding_cow_app/result.dart';
import 'package:coding_cow_app/widgets/main_measure.dart';
import 'package:coding_cow_app/widgets/transition_route_state.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data_global.dart';
import 'package:coding_cow_app/data_incorrects.dart';

import 'move_middle_to_circle_transition_route.dart';

void answer_input_dialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      final _answerEditController = TextEditingController();

      return Dialog(
        backgroundColor: Colors.white.withOpacity(0.5),// answer input dialogue
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.help_outline),
                color: Color(0xff2355DA),
                iconSize: 50,
                tooltip: "대소문자를 구분하여 입력해주세요. 연산자, 피연산자 간의 띄어쓰기는 정답과 무관합니다.",
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

                    // print("---------problem1--------");
                    // print(get_today_problems_ID);

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
                        // await incorrectsFromFirestore(auth.currentUser?.email);

                        get_incorrects_ID.forEach((incorrect) {
                          String docId = '${auth.currentUser?.email}_${incorrect}';// 문서 제목 (이메일_문제ID)
                          DocumentReference docRef = FirebaseFirestore.instance
                              .collection('incorrectProblems')
                              .doc(docId);

                          // 오답노트에 같은 문제가 존재할 경우 (현재 문제 ID == 오답노트의 문제 ID 순차탐색)
                          if (get_problems[problem_no].ID == incorrect) {
                            // cycle = 1일때 3일 뒤에 복습 -> cycle = 3일때 5일 뒤...
                            FirebaseFirestore.instance.runTransaction((transaction) async {
                              DocumentSnapshot docSnapshot = await transaction.get(docRef);

                              // 이미 해당 계정의 Incorrects에 존재하는 문제일 경우
                              if (docSnapshot.exists) {
                                int cycle = await docSnapshot.get('cycle');
                                // int count = await docSnapshot.get('count');
                                // print(cycle.toString()+"!!!!!!");

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
                                    break;
                                  // case 180:
                                  // incorrects DB에서 삭제
                                }

                                // reviewDate 속성은 lastSolved+복습주기
                                // count가 2 이상인 문제를 틀리면 다시 1일 뒤에 복습으로 변경
                                await transaction.update(docRef, {
                                  'cycle': new_cycle,
                                  'lastSolved': DateTime.now(),
                                  'reviewDate': DateTime.now().add(
                                      Duration(days: new_cycle)
                                  ),
                                });
                              } else {
                                // doc가 존재하지 않는다면(처음 틀린 문제) 새로 생성하고 count를 1로 설정
                                await transaction.set(docRef, {
                                  'email': auth.currentUser?.email,
                                  'problemId': problemId,
                                  'count': 1,
                                  'timestamp': DateTime.now(),
                                  'lastSolved': DateTime.now(),
                                  'reviewDate': DateTime.now().add(
                                      Duration(days: 1)
                                  ),
                                  'cycle': 1,
                                });
                              }
                            });
                          } else {
                            // doc가 존재하지 않는다면(처음 틀린 문제) 새로 생성하고 count를 1로 설정
                            FirebaseFirestore.instance.runTransaction((transaction) async {
                              DocumentSnapshot docSnapshot = await transaction.get(docRef);
                              if (docSnapshot.exists) {
                                transaction.set(docRef, {
                                  'email': auth.currentUser?.email,
                                  'problemId': problemId,
                                  'count': 1,
                                  'timestamp': DateTime.now(),
                                  'lastSolved': DateTime.now(),
                                  'reviewDate': DateTime.now().add(
                                      Duration(days: 1)
                                  ),
                                  'cycle': 1,
                                });
                              }
                            });
                          }
                        });

                        // print("---------problem2--------");
                        // print(get_today_problems_ID);

                        DocumentReference docRef = FirebaseFirestore.instance
                            .collection('users')
                            .doc(auth.currentUser?.email);

                        get_restEXP--;

                        await FirebaseFirestore.instance.runTransaction((transaction) async {
                          DocumentSnapshot docSnapshot = await transaction.get(docRef);
                          if (docSnapshot.exists) {
                            if (get_restEXP == 0) {
                              transaction.update(docRef, {'restEXP': 10});

                              get_level++;
                              transaction.update(docRef, {'level': get_level});
                            } else {
                              transaction.update(docRef, {'restEXP': get_restEXP});
                            }

                            // todaySolved++, problemsSolved++ (todaySolved는 매일 초기화)
                            get_todaySolved = docSnapshot.get('todaySolved');
                            get_problemsSolved = docSnapshot.get('problemsSolved');

                            get_todaySolved++;
                            get_problemsSolved++;

                            transaction.update(docRef, {
                              'todaySolved': get_todaySolved,
                              'problemsSolved': get_problemsSolved,
                            });
                          }
                        });
                      }

                      today_solved++;
                      today_progress = today_solved / today_problem_count;
                    }

                    // 답을 틀렸을 때
                    else {
                      status = 2;
                      await addIncorrectProblem(get_problems[problem_no].ID); // 답을 틀렸을 때 Incorrect DB에 저장
                    }

                    // totalScore 업데이트
                    await updateUserTotalScore(getCurrentUserId());

                    // 결과 화면으로 이동
                    Navigator.pushReplacement(
                      context,
                      TransitionRouteState(
                        page: Result_Page(status, uid: getCurrentUserId()),
                        transition: moveMiddleToCircleTransition,
                        duration: const Duration(seconds: 1),
                      ),
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
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ); // end of answer input dialog
    },
  );
}