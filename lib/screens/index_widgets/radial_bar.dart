
import 'package:flutter/material.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//chart to show the sleep efficiency of the day and the intensity of the exercise session/s of the day
//both from 0 to 100
class RadialBar extends StatefulWidget {
  const RadialBar({super.key});

  @override
  State<RadialBar> createState() => _RadialBarState();
}

class _RadialBarState extends State<RadialBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2), 
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward(); //start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SfCircularChart(
          legend: const Legend(
            isVisible: true, 
            overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CircularSeries>[
            RadialBarSeries<GDPData, String>(
              dataSource: getChartData(dataProvider),
              xValueMapper: (GDPData data, _) => data.type,
              yValueMapper: (GDPData data, _) => data.gdp * _animation.value, 
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true,
              maximumValue: 100,
            ),
          ],
        );
      },
    );
  }

  List<GDPData> getChartData(DataProvider dataProvider) {
    return [
      GDPData("Quality of Sleep", dataProvider.sleepEff.toInt()),
      GDPData("Intensity of today's session", dataProvider.intensity.toInt()), 
    ];
  }
}

class GDPData {
  GDPData(this.type, this.gdp);
  final String type;
  final int gdp;
}
