import 'package:flutter/material.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Weekly Trend of Rest Index",
            style: TextStyle(
              fontSize: 20, 
              color: Colors.indigo[600], 
              fontWeight: FontWeight.bold,
              fontFamily: 'CustomFont'
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              if (dataProvider.isLoading) {
                return CircularProgressIndicator();
              } else {
                return Container(); // Ritorna un contenitore vuoto quando non è in caricamento
              }
            },
          ),
        ],
      ),
    );
  }
}