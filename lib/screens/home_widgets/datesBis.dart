import 'package:flutter/material.dart';
import 'package:my_project/screens/index.dart';
import 'package:my_project/utils/dateHelpers.dart';
import 'package:provider/provider.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:intl/intl.dart';

//SENZA CLICCARE SULLE CASELLE DATA
/*
class DatesBis extends StatelessWidget {
  const DatesBis({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DataProvider>(context);
    DateTime startDate = dateProvider.startDate;

    List<DateBox> dateBoxes = [];
    DateTime date = startDate.subtract(Duration(days:7)); 

    for (int i = 0; i < 7; i++) {
      dateBoxes.add(DateBox(date: date));
      date = date.add(Duration(days: 1));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              //updateDates calls "getDataFromWeek"
              dateProvider.updateDates(-7);
            },
            child: Icon(Icons.navigate_before),
          ),
          ...dateBoxes,
          InkWell(
            onTap: () {
              dateProvider.updateDates(7);
            },
            child: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final DateTime date;

  const DateBox({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dayFormat = DateFormat('dd');
    final DateFormat monthFormat = DateFormat('MMM');

    return Container(
      width: 50,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 100, 108, 154)),
      ),
      child: DefaultTextStyle.merge(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              daysOfWeek[date.weekday]!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              dayFormat.format(date),
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),

            Text(
              monthFormat.format(date),
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

*/

//CLICCANDO SULLE CASELLE DATA

class DatesBis extends StatelessWidget {
  const DatesBis({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DataProvider>(context);
    DateTime startDate = dateProvider.startDate;

    List<DateBox> dateBoxes = [];
    DateTime date = startDate.subtract(Duration(days:7)); 

    for (int i = 0; i < 7; i++) {
      dateBoxes.add(DateBox(date: date));
      date = date.add(Duration(days: 1));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              //updateDates calls "getDataFromWeek"
              dateProvider.updateDates(-7);
            },
            child: Icon(Icons.navigate_before),
          ),
          ...dateBoxes,
          InkWell(
            onTap: () {
              dateProvider.updateDates(7);
            },
            child: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final DateTime date;

  const DateBox({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dayFormat = DateFormat('dd');
    final DateFormat monthFormat = DateFormat('MMM');
    final dateProvider = Provider.of<DataProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        await dateProvider.getDataFromDay(date);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Index()),
        );
      },
      child: Container(
        width: 50,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 100, 108, 154)),
        ),
        child: DefaultTextStyle.merge(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                daysOfWeek[date.weekday]!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                dayFormat.format(date),
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                monthFormat.format(date),
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


