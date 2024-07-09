import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_project/utils/data_provider.dart';

//main graph of the home page, it shows the weekly trend of the rest index 
class LineGraph extends StatelessWidget {
  const LineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        List<Map<String, dynamic>> chartData = [];

        //start date in the provider keeps track of the considered day, the line graph shows from that day until the 7th previous day (the previous week)
        DateTime startDate = dataProvider.startDate.subtract(const Duration(days:7));
        //weekindex it's the list of indexes given in output by the "getDataFromWeek" function (what is shown in this graph)
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
                title: const AxisTitle(text: 'Date'),
                dateFormat: DateFormat.MMMd(), // date format for x axis
                intervalType: DateTimeIntervalType.days, 
              ),
              primaryYAxis: const NumericAxis(title: AxisTitle(text: 'Rest Index')),
              series: [
                LineSeries<Map<String, dynamic>, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (data, _) => data['date'] as DateTime,
                  yValueMapper: (data, _) => data['index'] as double,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
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