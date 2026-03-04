import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MetricsLineChart extends StatelessWidget {
  final List<double> values;
  final double yMax;
  final String startLabel;
  final String endLabel;

  const MetricsLineChart({
    super.key,
    required this.values,
    required this.yMax,
    required this.startLabel,
    required this.endLabel,
  });

  static const Color _line = Color(0xFF8FD3FF);
  static const Color _bg = Color(0xFF1C1C1E);
  static const Color _grid = Color(0xFF2C2C2E);
  static const Color _muted = Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox(height: 170);

    final spots = List.generate(
      values.length,
      (i) => FlSpot(i.toDouble(), values[i]),
    );

    // Decide label formatter based on magnitude
    String formatLabel(double v) {
      if (v >= 1000) {
        return "${(v / 1000).toStringAsFixed(0)}K";
      }
      return v.toInt().toString();
    }

    return SizedBox(
      height: 170,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (values.length - 1).toDouble(),
          minY: 0,
          maxY: yMax,
          clipData: const FlClipData.none(),
          borderData: FlBorderData(show: false),

          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: yMax / 3,
            getDrawingHorizontalLine: (_) =>
                const FlLine(color: _grid, strokeWidth: 1, dashArray: [2, 6]),
          ),

          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                interval: yMax / 3,
                getTitlesWidget: (v, meta) {
                  if (v == 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      formatLabel(v),
                      style: const TextStyle(
                        fontSize: 11,
                        color: _muted,
                        height: 1.1,
                      ),
                    ),
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                interval: (values.length - 1).toDouble(),
                getTitlesWidget: (v, meta) {
                  if (v == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text(
                        startLabel,
                        style: const TextStyle(fontSize: 11, color: _muted),
                      ),
                    );
                  }
                  if (v == (values.length - 1).toDouble()) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, right: 30),
                      child: Text(
                        endLabel,
                        style: const TextStyle(fontSize: 11, color: _muted),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: values.length > 30, // smooth for long ranges
              curveSmoothness: 0.3,
              barWidth: values.length > 30 ? 1.0 : 1.5,
              color: _line,

              dotData: FlDotData(
                show: values.length <= 30, // hide dots for 365-day dense data
                getDotPainter: (spot, percent, bar, index) {
                  return FlDotCirclePainter(
                    radius: 2.6,
                    color: _line,
                    strokeWidth: 1.6,
                    strokeColor: _bg,
                  );
                },
              ),

              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _line.withOpacity(0.12),
                    _line.withOpacity(0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],

          lineTouchData: const LineTouchData(enabled: false),
        ),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      ),
    );
  }
}
