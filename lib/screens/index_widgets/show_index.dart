import 'package:flutter/material.dart';

//box that shows the rest index (number + LinearProgressorIndicator) + a short text and an icon based on it
//contains also an info button that tells what is the index (AlertDialog)

class ShowIndex extends StatelessWidget {
  final int computedIndex;

  const ShowIndex({Key? key, required this.computedIndex}) : super(key: key);

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "The Rest Index is a measure of your current physical state. "
            "A lower index indicates higher tiredness and the need for rest, "
            "while a higher index suggests you are less tired and managing stress well.",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //they're different based on the index value (3 types of settings)
    Color textColor;
    String message;
    IconData icon;

    if (computedIndex <= 50) {
      textColor = Colors.red;
      message = "You look very tired, take some rest";
      icon = Icons.sentiment_very_dissatisfied;
    } else if (computedIndex <= 75) {
      textColor = Colors.orange;
      message = "You're doing well, but try to take a break";
      icon = Icons.sentiment_neutral;
    } else {
      textColor = Colors.green;
      message = "Great job! Keep it up, you're doing fantastic";
      icon = Icons.sentiment_very_satisfied;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: textColor, width: 2),
      ),
      //to place the icon on top of the other things
      child: Stack(
        children: [
          //to place the icon where I want 
          Positioned(
            top: -10, 
            right: -10,
            child: IconButton(
              icon: Icon(Icons.info, color: textColor),
              onPressed: () => _showInfoDialog(context),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: textColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rest Index: $computedIndex",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: computedIndex / 100,
                backgroundColor: textColor.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
