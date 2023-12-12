import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:queue_system/models/point.dart';

class SimulationView extends StatelessWidget {
  const SimulationView({super.key , required this.data});
  final List<Point> data;

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
          titlesData: const FlTitlesData(
            bottomTitles: AxisTitles(axisNameWidget: Text('Clock')),
            rightTitles:  AxisTitles(axisNameWidget: Text('Num in system')),
          ),
      minX: 0,
      minY: 0,

      lineBarsData: [
        LineChartBarData(
          spots: data.map((point) => FlSpot(point.x, point.y)).toList(),
          dotData: const FlDotData(
            show: false,
          ),
          lineChartStepData: const LineChartStepData(
            stepDirection: 0
          ),
          isStepLineChart: true,
          color: Colors.deepPurple,
          isCurved: true,
        ),
      ]
    ));
  }

}