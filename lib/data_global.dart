import 'dart:core';
import 'package:coding_cow_app/data_problems.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<Problems> get_problems = []; // 오늘의 문제, 오답
List<String> get_incorrects_ID = [];
List<String> get_today_problems_ID = [];
List<DateTime> get_incorrects_date = [];
int today_review = 0;
int today_prev_level = 0;
int today_current_level = 0;
int today_next_level = 0;
String get_nickname = '';
int get_level = 0;
int get_restEXP = 0;
int get_todaySolved = 0;
int get_problemsSolved = 0;
String current_email = '';
int new_cycle = 0;
final FirebaseAuth auth = FirebaseAuth.instance;

int mode = 0; // 0: 오늘의 문제, 1: 오답 문제
int today_problem_count = 10;
var hint = false; // hint 열람 여부
int problem_no = 0; // 문제 번호
String memo = ""; // 문제 풀이를 위한 메모
int today_solved = 0; // 오늘의 푼 문제 수
double today_progress = 0.0; // 오늘의 푼 문제 비율 (푼 문제 수/10)