import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_project/utils/data_provider.dart';

/*
class LineGraph extends StatelessWidget {
  const LineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {

        DateTime startDate = dataProvider.startDate;
        List weekIndex = dataProvider.weekindex;

        List<List<dynamic>> chartData = [];
        DateTime date = startDate;

        for (int i = 0; i < weekIndex.length; i++) {
          chartData.add([date.day, weekIndex[i]]);
          date = date.add(Duration(days: 1));
        }

        return Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: NumericAxis(title: AxisTitle(text: 'Date')),
              primaryYAxis: NumericAxis(title: AxisTitle(text: 'Rest Index')),
              series: [
                LineSeries(
                  dataSource: chartData,
                  xValueMapper: (data, index) => data[0],
                  yValueMapper: (data, index) => data[1],
                  markerSettings: MarkerSettings(isVisible: true),
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  color: Colors.indigo[600],
                  name: 'Rest Index on the selected date',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
*/

class LineGraph extends StatelessWidget {
  const LineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        List<Map<String, dynamic>> chartData = [];

        DateTime startDate = dataProvider.startDate.subtract(Duration(days:7));
        List weekIndex = dataProvider.weekindex;

        // adds dates and indexes to chartData
        DateTime date = startDate;
        for (int i = 0; i < weekIndex.length; i++) {
          chartData.add({'date': date, 'index': weekIndex[i].toDouble()});
          date = date.add(Duration(days: 1));
        }

        return Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: DateTimeAxis(
                title: AxisTitle(text: 'Date'),
                dateFormat: DateFormat.MMMd(), // date format for x axis
                intervalType: DateTimeIntervalType.days, 
              ),
              primaryYAxis: NumericAxis(title: AxisTitle(text: 'Rest Index')),
              series: [
                LineSeries<Map<String, dynamic>, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (data, _) => data['date'] as DateTime,
                  yValueMapper: (data, _) => data['index'] as double,
                  markerSettings: MarkerSettings(isVisible: true),
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  color: Colors.indigo[600],
                  name: 'Rest Index on the selected date',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}