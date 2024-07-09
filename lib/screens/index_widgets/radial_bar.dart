
import 'package:flutter/material.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
      duration: Duration(seconds: 2), // Durata dell'animazione
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward(); // Inizia l'animazione
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
          legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CircularSeries>[
            RadialBarSeries<GDPData, String>(
              dataSource: getChartData(dataProvider),
              xValueMapper: (GDPData data, _) => data.type,
              yValueMapper: (GDPData data, _) => data.gdp * _animation.value, // Animazione dei valori
              dataLabelSettings: DataLabelSettings(isVisible: true),
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
