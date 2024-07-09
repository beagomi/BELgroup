import 'package:flutter/material.dart';
import 'package:my_project/screens/index.dart';
import 'package:my_project/screens/info.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

//it's the button of the home page that, if pressed, leads to the index page where the index and the insights are shown 
//when pressed it calls "getDataFromDay" to fetch the data from the server, the data is used to compute the index
//and to show all the other graphs/widgets

class ComputeIndex extends StatelessWidget {
  const ComputeIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(  
          padding: EdgeInsets.symmetric(vertical:10),
          child: Consumer<DataProvider>(builder: (context, provider, child) {
          return SizedBox(
            height: 70,
            child: Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      //what is substituted when calling the function
                      DateTime day = DateTime.now().subtract(Duration(days: 1));

                      //starts fetching the data and goes to the screen to visualize the index and its widgets
                      Provider.of<DataProvider> (context, listen: false).getDataFromDay(day); 
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Index())
                      );
                    },
                    child: Text(
                      "Compute Today's Index", 
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.indigo[400], 
                      disabledForegroundColor: Colors.grey.withOpacity(0.38),
                    ),
                  ),

                //small button used to go to the info page where info about the index are shown 
                IconButton(
                    icon: Icon(Icons.info,
                    color: Colors.indigo[200],
                    size: 30),
                    onPressed: () {
                      Navigator.push(
                         context, MaterialPageRoute(builder: (context) => Info())
                      );
                      },
                  ),
            ],
            ),
          );
       }),
      ),
      );
  }
}
