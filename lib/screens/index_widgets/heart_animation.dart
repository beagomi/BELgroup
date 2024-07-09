import 'package:flutter/material.dart';

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
          SizedBox(height: 5), // Spazio tra l'animazione e il testo
          Text(
            'Average Heart Rate: $averageHeartRate bpm',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'CustomFont'),
          ),
        ],
      ),
    );
  }
}
