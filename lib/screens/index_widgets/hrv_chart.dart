import 'package:flutter/material.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class HRVChart extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);

    //get HRV data from provider
    final List<double> time = List.generate(dataProvider.hrList.length, (index) => index.toDouble());
    final List<double> hrv = dataProvider.hrList;

    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          margin: EdgeInsets.all(16),
          child: SfCartesianChart(
            primaryXAxis: const NumericAxis(
              title: AxisTitle(text: 'Time'), // X-axis label
              labelStyle: TextStyle(color: Colors.transparent),
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'HRV'), // Y-axis label
            ),
            series: <CartesianSeries>[
              LineSeries<_ChartData, double>(
                // Use time and hrv vectors as dataSource
                dataSource: _getChartData(time, hrv),
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                color: Colors.blue, // Line color
              ),
              ScatterSeries<_ChartData, double>(
                // Use time and hrv vectors as dataSource
                dataSource: _getChartData(time, hrv),
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  isVisible: true, // Show markers at data points
                  color: Colors.blue, // Marker color
                  height: 2.0,
                  width: 2.0,
                  shape: DataMarkerType.none
                ),
              ),
              AreaSeries<_ChartData, double>(
                // Use time and hrv vectors as dataSource
                dataSource: _getChartData(time, hrv),
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withOpacity(0.8), // Top color (80% opacity)
                    Colors.blue.withOpacity(0.2), // Bottom color (20% opacity)
                  ],
                ),
              ),
            ],
            tooltipBehavior: TooltipBehavior(
              enable: true,
              builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 3),
                    ],
                  ),
                  child: Text(
                    'Time: ${data.x} s\nHRV: ${data.y}',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }, 
              //animationDuration: 2000,
            ),
            enableAxisAnimation: true,
          ),
        ),
      ),
    );
  }

  // Function to combine time and hrv vectors into chart data
  List<_ChartData> _getChartData(List<double> time, List<double> hrv) {
    List<_ChartData> chartData = [];
    for (int i = 0; i < time.length; i++) {
      if (i % 200 == 0) { // Show markers only for every 200th data point to make the graph more legible
        chartData.add(_ChartData(time[i], hrv[i]));
      } else {
        chartData.add(_ChartData(time[i], hrv[i], showMarker: false));
      }
    }
    return chartData;
  }
}

class _ChartData {
  final double x;
  final double y;
  final bool showMarker;

  _ChartData(this.x, this.y, {this.showMarker = true});
}


