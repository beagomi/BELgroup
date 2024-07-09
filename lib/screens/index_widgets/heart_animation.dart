import 'package:flutter/material.dart';

//widget showing an heart beating and the mean fc of the day
class HeartBeat extends StatelessWidget {
  final int averageHeartRate;

  HeartBeat({required this.averageHeartRate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/giphy-2.gif'),
          const SizedBox(height: 5),
          Text(
            'Average Heart Rate: $averageHeartRate bpm',
            style: const TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.bold, 
              fontFamily: 'CustomFont'),
          ),
        ],
      ),
    );
  }
}
