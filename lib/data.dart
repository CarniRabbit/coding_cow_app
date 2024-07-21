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
      category: json["answer"],
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

// 문제ID, 레벨, 언어(1: 파이썬, 2: C언어), 프로그램 제목, 문제 유형, 정답, 힌트, 출처
// var problems = [
//   [
//     'ex0001-1', // 0
//     4, // 1
//     2, // 2
//     '짝수/홀수 판별 프로그램', // 3
//     """
//     <span class='blue'>#include</span> &lt;<span class='red'>stdio.h</span>&gt;<br/>
//     int main() {<br/>
//     <div class='first'>
//     <span class='blue'>int</span> n = 3;<br/>
//     <span class='blue'>if</span> (<span class="answer">정답 입력</span>) {<br/>
//     <div class='second'>printf(<span class='red'>"짝수입니다."</span>);</div>
//     }<br/>
//     <span class='blue'>else</span> {<br/>
//     <div class='second'>printf(<span class='red'>"홀수입니다."</span>);</div><br/>
//     }
//     <span class='blue'>return</span> 0;<br/>
//     </div><br/>
// }""", // 4
//     '주관식 문제', // 5
//     'n%2==0', // 6
//     '''* 짝수와 홀수의 정의에 대해서 생각해봅시다.
//
// 어떤 수를 짝수라고 하고, 어떤 수를 홀수라고 할까요?
// 짝수는 2의 배수이기도 합니다. 어떻게 하면 if문에서 2의 배수를 찾아낼 수 있을까요?
// 어떤 산술 연산자를 사용할지 고민해봅시다.''', // 7
//     '프로그래머스(programmers)' // 8
//   ],
//   [
//     'ex0002-1', // 0
//     5, // 1
//     2, // 2
//     '십의 자리수 구하는 프로그램', // 3
//     """
//     <span class='blue'>#include</span> &lt;<span class='red'>stdio.h</span>&gt;<br/>
// <span class='blue'>int</span> main() {<br/>
//     <div class='first'>
//         <span class='blue'>int</span> n = 0;<br/>
//         printf(<span class='red'>"숫자를 입력해주세요:"</span>);<br/>
//         scanf(<span class='red'>"%d"</span>, &n);<br/><br/>
//
//         printf(<span class='red'>"십의 자리수: %d\\n"</span>, <span class="answer">정답 입력</span>);<br/>
//         <span class='blue'>return</span> 0;<br/>
//     </div>
// }
//     """, // 4
//     '주관식 문제', // 5
//     'n%100', // 6
//     '''adsfasdfasdf''', // 7
//     '프로그래머스(programmers)' // 8
//   ],
//   [
//     'ex0003-1', // 0
//     7, // 1
//     2, // 2
//     '삼각형 출력 프로그램(1)', // 3
//     """
//     <span class='blue'>#include</span> &lt;<span class='red'>stdio.h</span>&gt;<br/>
//     <span class='blue'>int</span> main() {<br/>
//         <div class='first'>
//             <span class='blue'>int</span> n = 4;<br/><br/>
//
//             <span class='blue'>for</span> (<span class='blue'>int</span> i = 1; i &lt;= n; i++) {<br/>
//                 <div class='second'>
//                     <span class='blue'>for</span> (<span class='blue'>int</span> j = 1;<span class="answer">정답 입력</span>; j++) {<br/>
//                         <div class='third'>printf(<span class='red'>"*"</span>);</div>
//                     }<br/>
//                     printf(<span class='red'>"\\n"</span>);<br/>
//                 </div>
//             }<br/>
//             <span class='blue'>return</span> 0;<br/>
//         </div>
//     }
//     """, // 4
//     '주관식 문제', // 5
//     'j<=i', // 6
//     '''adfasdfdfsddd''', // 7
//     '프로그래머스(programmers)' // 8
//   ],
// ];

var hint = false; // hint 열람 여부
var problem_no = 0; // 문제 번호