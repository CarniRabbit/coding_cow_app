import 'package:flutter/material.dart';

// 문제ID, 레벨, 언어(1: C언어, 2: 파이썬), 프로그램 제목, 문제 유형, 정답, 힌트, 출처
var problems = [
  [
    'S0001',
    4,
    1,
    '짝수/홀수 판별 프로그램',
    'Short answer',
    'n%2==0',
    '''* 짝수와 홀수의 정의에 대해서 생각해봅시다.
어떤 수를 짝수라고 하고, 어떤 수를 홀수라고 할까요?
짝수는 2의 배수이기도 합니다. 어떻게 하면 if문에서 2의 배수를 찾아낼 수 있을까요?
어떤 산술 연산자를 사용할지 고민해봅시다.''',
    '프로그래머스(programmers)'
  ],
  [
    'S0002',
    5,
    1,
    '십의 자리수 구하는 프로그램',
    'Short answer',
    'n%100==0',
    '''adsfasdfasdf''',
    '프로그래머스(programmers)'
  ],
  [
    'S0003',
    7,
    1,
    '삼각형 출력 프로그램(1)',
    'Short answer',
    'i<=j',
    '''adfasdfdfsddd''',
    '프로그래머스(programmers)'
  ],
];

var hint = false; // hint 열람 여부