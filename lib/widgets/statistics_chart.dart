/*
원형차트 로직 및 애니메이션
 */

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data.dart';

class StatisticsChart extends StatefulWidget {
  final UserStats userStats;

  StatisticsChart({Key? key, required this.userStats}) : super(key: key);

  @override
  _StatisticsChartState createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart>
    with SingleTickerProviderStateMixin {
  int touchedIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 1, end: 1.5).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<PieChartSectionData> showingSections(UserStats userStats) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 50.0 * _animation.value : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: (widget.userStats.correctProblemsCount /
                    widget.userStats.totalProblemsSolved)
                .toDouble(),
            title:
                '${(widget.userStats.correctProblemsCount / widget.userStats.totalProblemsSolved * 100).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: (widget.userStats.hintUsedProblemsCount /
                    widget.userStats.totalProblemsSolved)
                .toDouble(),
            title:
                '${(widget.userStats.hintUsedProblemsCount / widget.userStats.totalProblemsSolved * 100).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: (widget.userStats.incorrectProblemsCount /
                    widget.userStats.totalProblemsSolved)
                .toDouble(),
            title:
                '${(widget.userStats.incorrectProblemsCount / widget.userStats.totalProblemsSolved * 100).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              const SizedBox(height: 18),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (event is FlTapUpEvent ||
                                event is FlLongPressEnd) {
                              if (pieTouchResponse != null &&
                                  pieTouchResponse.touchedSection != null) {
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                                _animationController.forward(from: 0);
                              } else {
                                touchedIndex = -1;
                                _animationController.reverse();
                              }
                            }
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(widget.userStats),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: Colors.blue,
                    text: 'correct',
                    isSquare: true,
                  ),
                  SizedBox(height: 4),
                  Indicator(
                    color: Colors.yellow,
                    text: 'hint used',
                    isSquare: true,
                  ),
                  SizedBox(height: 4),
                  Indicator(
                    color: Colors.purple,
                    text: 'Incorrect',
                    isSquare: true,
                  ),
                  SizedBox(height: 18),
                ],
              ),
              const SizedBox(width: 28),
            ],
          ),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
