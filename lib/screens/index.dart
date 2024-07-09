
import 'package:flutter/material.dart';
import 'package:my_project/screens/index_widgets/advice_section.dart';
import 'package:my_project/screens/index_widgets/heart_animation.dart';
import 'package:my_project/screens/index_widgets/hrv_chart.dart';
import 'package:my_project/screens/index_widgets/radial_bar.dart';
import 'package:my_project/screens/index_widgets/session_type.dart';
import 'package:my_project/screens/index_widgets/show_index.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';


class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REST INDEX INSIGHTS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'CustomFont'
            )
        ),
        
        backgroundColor: Colors.indigo[200],
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (!dataProvider.hasData) {
              return _buildNoDataView();
            } else {
              return _buildContent(context);
            }
          }
        },
      ),
    );
  }



  //what is shown if there are no data for the day
  Widget _buildNoDataView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'No data available for the day.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Future<void> _loadData(BuildContext context) async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    await dataProvider.getDataFromDay(DateTime.now());
  }

  //what is shown if there are data
  Widget _buildContent(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    int computedIndex = dataProvider.index.ceil(); //to bigger int
    List types = dataProvider.types;
    //to make them a list o strings, the correct format for the session type widget
    List<String> activities = types.cast<String>(); 
    int hr = dataProvider.fcRest.toInt();

    /*
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(child: ShowIndex(computedIndex: computedIndex)),
          SizedBox(height: 20),
          Container(child: AdviceSection(computedIndex: computedIndex)),
          
          Container(
            height: 300,
            width: 300,
            child: 
                RadialBar(),
          ),
          Container(
            height: 300,
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: HRVChart(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 150,
            child: SessionType(),
          ),
          SizedBox(height: 20),
          Container(
            //height: 100,
            child: HeartBeat(averageHeartRate: hr)
          ),
            
        ],
      ),
    );
  }
}

*/
return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(child: ShowIndex(computedIndex: computedIndex)),
          SizedBox(height: 20),
          Container(child: AdviceSection(computedIndex: computedIndex)),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Factors contributing to your Rest Index:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CustomFont'
                  ),
                ),

                //SLEEP/INTENSITY
                Divider(thickness: 1, color: Color.fromARGB(255, 224, 224, 224)),
                SizedBox(height: 8),
                Text(
                  "The quality of sleep and the intensity of workouts are the primary factors influencing perceived tiredness and, consequently, the need for rest",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 300,
            width: double.infinity,
            child: RadialBar(),
          ),
          SizedBox(height: 2),
          Divider(thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 10),

          //SESSION TYPE
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What you've done today: ",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            child: SessionType(),
          ),
          SizedBox(height: 20),
          Divider(thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 20),

          //HRV
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Heart Rate Variability reflects how well your body adapts to physical stress and recovers after workouts.",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 300,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: HRVChart(),
            ),
          ),

          //MEAN FREQUENCY 
          Divider(thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily average heart rate serves as an indicator of an individual's level of fitness and training status, with a lower rate typically indicative of a well-trained individual",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: HeartBeat(averageHeartRate: hr),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}