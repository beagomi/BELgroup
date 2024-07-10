import 'package:flutter/material.dart';
import 'package:my_project/screens/home.dart';
import 'package:my_project/screens/home_widgets/loading_animation.dart';
import 'package:my_project/screens/home_widgets/rotatingText.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

//screen shown when, after loggin in, the data of the week are fetched (it takes a few seconds)
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false); 
    final DateTime day = DateTime.now(); //gets the data from today until 7 days ago (= past week)

    Future<void> loadData() async {
      await dataProvider.getDataFromWeek(day);
      // once loading is done, goes to the home page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }

    // to call loadData() at the beginning, when loading screen has just been shown
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loadData();
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_provvisorio.png', scale: 4),
            const SizedBox(height: 40),
            // animation for loading instead of "CircularProgressorIndicator"
            const LoadingAnimation(),
            const SizedBox(height: 40),
            // shows some short expression telling the user to wait and be patient
            const RotatingText(),
          ],
        ),
      ),
    );
  }
}