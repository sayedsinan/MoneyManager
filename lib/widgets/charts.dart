import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  final int indexx;
  final double income;
  final double expenses;

  const Chart({
    Key? key,
    required this.indexx,
    required this.income,
    required this.expenses,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final double total = income + expenses;

    if (total <= 0) {
      return [
        PieChartSectionData(
          color:
              Colors.grey, // You can use a different color to indicate no data.
          value: 100.0, // 100% for no data
          title: 'No Data',
          radius: 50,
          titleStyle:const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ];
    }

    final double incomePercentage = (income / total) * 100;
    final double expensesPercentage = (expenses / total) * 100;

    return [
      PieChartSectionData(
        color:const Color.fromARGB(255, 47, 125, 121),
        value: incomePercentage,
        title: '${income.toStringAsFixed(2)}',
        radius: 50,
        titleStyle:const  TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      PieChartSectionData(
        color:const Color.fromARGB(255, 186, 37, 27),
        value: expensesPercentage,
        title: '${expenses.toStringAsFixed(2)}',
        radius: 50,
        titleStyle:const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    ];
  }
}
