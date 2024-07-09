import 'package:flutter/material.dart';
import 'dart:async';

//WIDGET USED IN THE SPLASH PAGE WHILE WAITING 
//we need it because before going to the home page we have to fetch all week data from the server so we need to wait some time
//making the waiting more fun 

class RotatingText extends StatefulWidget {
  const RotatingText({Key? key}) : super(key: key);

  @override
  _RotatingTextState createState() => _RotatingTextState();
}

class _RotatingTextState extends State<RotatingText> {
  final List<String> texts = [
    "Getting things ready for you...",
    "Just a moment, good things take time!",
    "Hold on, making sure everything's perfect!",
    "Preparing your personalized insights...",
    "Hang tight, we're almost there!",
    "Just a sec, fine-tuning your data!",
    "We’re on it, sit back and relax!"
  ];
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTextRotation();
  }

  void _startTextRotation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      texts[currentIndex],
      style: TextStyle(
        fontFamily: 'CustomFont',
        fontSize: 14, 
        fontWeight: FontWeight.w400,
        color: Colors.indigo[300]
        ),
      textAlign: TextAlign.center,
        
    );
  }
}
