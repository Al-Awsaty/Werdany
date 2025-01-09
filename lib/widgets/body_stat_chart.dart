import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:your_app/models/body_stats.dart';

class BodyStatChart extends StatelessWidget {
  final List<BodyStats> bodyStats;

  BodyStatChart({required this.bodyStats});

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
            dotData: FlDotData(show: true),
            showingIndicators: [0, 1, 2, 3, 4, 5],
            tooltipData: FlTooltipData(
              tooltipBgColor: Colors.blueAccent,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((barSpot) {
                  return LineTooltipItem(
                    '${barSpot.y}',
                    const TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ),
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
            dotData: FlDotData(show: true),
            showingIndicators: [0, 1, 2, 3, 4, 5],
            tooltipData: FlTooltipData(
              tooltipBgColor: Colors.greenAccent,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((barSpot) {
                  return LineTooltipItem(
                    '${barSpot.y}',
                    const TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ),
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
            dotData: FlDotData(show: true),
            showingIndicators: [0, 1, 2, 3, 4, 5],
            tooltipData: FlTooltipData(
              tooltipBgColor: Colors.redAccent,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((barSpot) {
                  return LineTooltipItem(
                    '${barSpot.y}',
                    const TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(showTitles: true),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: true),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
          ),
          touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches: true,
        ),
        panAndZoomData: PanAndZoomData(
          enabled: true,
          maxScale: 2,
          minScale: 0.5,
        ),
      ),
    );
  }
}
