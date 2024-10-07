import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// 일주일 간 푼 문제 수 가져오기
Future<List<ProblemData>> fetchWeeklyProblems(String uid) async {
  List<ProblemData> problemCounts = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime today = DateTime.now();

  for (int i = 0; i < 7; i++) {
    DateTime date = today.subtract(Duration(days: i));
    String dateKey = date.toIso8601String().split('T').first;

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('todayProblems')
        .where('uid', isEqualTo: uid)
        .where('date', isEqualTo: dateKey)
        .get();

    int count = (snapshot.docs.length * 10);

    problemCounts.add(ProblemData(date: dateKey, count: count));
  }

  return problemCounts.reversed.toList();
}

class ProblemData {
  final String date;
  final int count;

  ProblemData({required this.date, required this.count});
}

class WeeklyProblemsChart extends StatelessWidget {
  final String uid;

  WeeklyProblemsChart({required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProblemData>>(
      future: fetchWeeklyProblems(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data'));
        } else {
          List<ProblemData> problemData = snapshot.data!;

          return Container(
            child: AspectRatio(
              aspectRatio: 1.25,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: LineChart(lineChartData(problemData)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  LineChartData lineChartData(List<ProblemData> problemData) {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (double _) => FlLine(
          color: Colors.white.withOpacity(0.2),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (double _) => FlLine(
          color: Colors.white.withOpacity(0.2),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: (value, meta) {
              const List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
              int index = value.toInt();
              if (index >= 0 && index < weekdays.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 10,
                  child: Text(
                    weekdays[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: (value, meta) {
              return Text(
                value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              );
            },
            showTitles: true,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // 오른쪽 Y축 비표기
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF50E4FF).withOpacity(0.2),
            width: 4,
          ),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: problemData.map((e) => e.count).reduce((a, b) => a > b ? a : b) + 1,
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
          spots: problemData
              .asMap()
              .entries
              .map((entry) => FlSpot(entry.key.toDouble(), entry.value.count.toDouble()))
              .toList(),
        ),
      ],
    );
  }
}