import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:your_app/models/body_stats.dart';

class ProgressVisualization extends StatelessWidget {
  final List<BodyStats> bodyStats;

  ProgressVisualization({required this.bodyStats});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: bodyStats
                .map((stat) => FlSpot(
                      stat.date.millisecondsSinceEpoch.toDouble(),
                      stat.weight,
                    ))
                .toList(),
            isCurved: true,
            colors: [Colors.blue],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: bodyStats
                .map((stat) => FlSpot(
                      stat.date.millisecondsSinceEpoch.toDouble(),
                      stat.muscleMass,
                    ))
                .toList(),
            isCurved: true,
            colors: [Colors.green],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: bodyStats
                .map((stat) => FlSpot(
                      stat.date.millisecondsSinceEpoch.toDouble(),
                      stat.fatPercentage,
                    ))
                .toList(),
            isCurved: true,
            colors: [Colors.red],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(showTitles: true),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: true),
      ),
    );
  }
}
