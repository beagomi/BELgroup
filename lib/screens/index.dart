
import 'package:flutter/material.dart';
import 'package:my_project/screens/index_widgets/advice_section.dart';
import 'package:my_project/screens/index_widgets/heart_animation.dart';
import 'package:my_project/screens/index_widgets/hrv_chart.dart';
import 'package:my_project/screens/index_widgets/radial_bar.dart';
import 'package:my_project/screens/index_widgets/session_type.dart';
import 'package:my_project/screens/index_widgets/show_index.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

//the page showing everything about the computed index and its widgets

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
          //in the provider we always know the state of the fetching, based on that show the CircularProgressIndicator
          if (dataProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
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

  //what is shown if there are data
  Widget _buildContent(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    int computedIndex = dataProvider.index.ceil(); //to bigger int 
    int hr = dataProvider.fcRest.toInt();

//to make the whole column page scrollable
return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            //show the index
            child: ShowIndex(computedIndex: computedIndex)
            ),
          const SizedBox(height: 20),
          Container(
            //show the advices 
            child: AdviceSection(computedIndex: computedIndex)
            ),


          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 10),
          Container(
            height: 300,
            width: double.infinity,
            child: const RadialBar(),
          ),
          const SizedBox(height: 2),
          Divider(thickness: 1, color: Colors.grey[300]),
          const SizedBox(height: 10),

          //SESSION TYPE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            child: SessionType(),
          ),
          const SizedBox(height: 20),
          Divider(thickness: 1, color: Colors.grey[300]),
          const SizedBox(height: 20),

          //HRV
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 10),
          Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: HRVChart(),
            ),
          ),

          //MEAN FREQUENCY 
          Divider(thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HeartBeat(averageHeartRate: hr),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}