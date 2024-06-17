/*
 * edit: 2024-06-15
 * 딩카 전역변수 저장
 * DB에서 select한 row
 */

/*
 * 공통 규칙
 * 각 위젯마다 시작, 끝 주석으로 표기하기
 * 속성에 대한 간략한 설명 주석으로 넣기
 * 한글 작성시 항상 자간 -2 (letterSpacing: -2)
 * 다음 속성이 없더라도 무조건 반점 찍기
 * icon 종류는 https://www.fluttericon.com/ 에서 마우스 올려보기
 * 조건에 따라 화면이 바뀌는 경우 삼항연산자 사용할 것. 오히려 if, switch-case가 더 어려움.
 */


import 'package:flutter/material.dart';

// 문제ID, 레벨, 언어(1: 파이썬, 2: C언어), 프로그램 제목, 문제 유형, 정답, 힌트, 출처
var problems = [
  [
    'ex0001-1',
    4,
    2,
    '짝수/홀수 판별 프로그램',
    """
    <span class='blue'>#include</span> &lt;<span class='red'>stdio.h</span>&gt;<br/>
    int main() {<br/>
    <div class='first'>
    <span class='blue'>int</span> n = 3;<br/>
    <span class='blue'>if</span> (<span class="answer">정답 입력</span>) {<br/>
    <div class='second'>printf(<span class='red'>"짝수입니다."</span>);</div>
    }<br/>
    <span class='blue'>else</span> {<br/>
    <div class='second'>printf(<span class='red'>"홀수입니다."</span>);</div><br/>
    }
    <span class='blue'>return</span> 0;<br/>
    </div><br/>
}""",
    '주관식 문제',
    'n%2==0',
    '''* 짝수와 홀수의 정의에 대해서 생각해봅시다.
    
어떤 수를 짝수라고 하고, 어떤 수를 홀수라고 할까요?
짝수는 2의 배수이기도 합니다. 어떻게 하면 if문에서 2의 배수를 찾아낼 수 있을까요?
어떤 산술 연산자를 사용할지 고민해봅시다.''',
    '프로그래머스(programmers)'
  ],
  [
    'ex0002-1',
    5,
    2,
    '십의 자리수 구하는 프로그램',
    '''<span>#include</span> &lt;stdio.h&gt;<br/>
int main() {<br/>
   int n = 0;<br/>
   printf("숫자를 입력해주세요:");<br/>
   scanf("%d", &n);<br/><br/>

   printf("십의 자리수: %d\\n", n%100);<br/>
   return 0;<br/>
}''',
    '주관식 문제',
    'n%100',
    '''adsfasdfasdf''',
    '프로그래머스(programmers)'
  ],
  [
    'ex0003-1',
    7,
    2,
    '삼각형 출력 프로그램(1)',
    '''<span>#include</span> &lt;stdio.h&gt;<br/>
int main() {<br/>
   int n = 4;<br/><br/>

   for (int i = 1; i<=n; i++) {<br/>
      for (int j = 1; j<=i; j++) {<br/>
         printf("*");<br/>
      }<br/>
      printf("\\n");<br/>
   }<br/>
   return 0;<br/>
}''',
    '주관식 문제',
    'i<=j',
    '''adfasdfdfsddd''',
    '프로그래머스(programmers)'
  ],
];

var hint = false; // hint 열람 여부
var problem_no = 0;