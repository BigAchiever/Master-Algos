import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class BottomPointer extends StatelessWidget {
  final int length;
  final List<int> pointers;

  const BottomPointer({Key? key, required this.length, required this.pointers})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 320,
      child: Stack(
        children: pointers
            .map(
              (item) => Padding(
                padding:
                    EdgeInsets.only(left: (330 / length) * item.toDouble()),
                child: const Icon(
                  Icons.arrow_upward,
                  color: activeData,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  final List<int> numbers;
  final List<int> activeElements;

  const ChartWidget(
      {Key? key, required this.numbers, required this.activeElements})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          mainBarData(),
          swapAnimationDuration: animDuration,
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    int y, {
    Color barColor = Colors.white,
    double width = 10,
  }) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        fromY: y.toDouble(),
        borderRadius: BorderRadius.circular(10.0),
        color: barColor,
        width: width,
        backDrawRodData: BackgroundBarChartRodData(
            show: true, fromY: 12, color: primaryDark),
        toY: 12,
      ),
    ]);
  }

  List<BarChartGroupData> showingGroups() {
    return numbers.map((f) {
      return makeGroupData(numbers.indexOf(f), f,
          barColor: activeElements.contains(numbers.indexOf(f))
              ? Colors.yellow
              : Colors.white);
    }).toList();
  }

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  numbers[value.toInt()].toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                );
              },
              // reservedSize: 20,
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}

class SoringAlgorithmsList extends StatefulWidget {
  final bool isDisabled;
  final Function(String) onTap;

  const SoringAlgorithmsList(
      {Key? key, this.isDisabled = false, required this.onTap})
      : super(key: key);
  @override
  _SoringAlgorithmsListState createState() => _SoringAlgorithmsListState();
}

class _SoringAlgorithmsListState extends State<SoringAlgorithmsList> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: sortingAlgorithmsList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (!widget.isDisabled) {
                setState(() {
                  selected = index;
                });
                widget.onTap(sortingAlgorithmsList[selected].title);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: widget.isDisabled && !(selected == index)
                      ? primary
                      : selected == index
                          ? accent
                          : primaryDark,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Center(
                child: Text(
                  sortingAlgorithmsList[index].title,
                  style: TextStyle(
                    fontSize: 14,
                    color: selected == index ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
