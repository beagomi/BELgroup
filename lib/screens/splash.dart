import 'package:flutter/material.dart';
import 'package:my_project/screens/home.dart';
import 'package:my_project/screens/home_widgets/loading_animation.dart';
import 'package:my_project/screens/home_widgets/rotatingText.dart';
import 'package:my_project/screens/login.dart';
import 'package:my_project/utils/impact.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);


  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const Login())));
  } //_toHomePage

// Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
  } //_toHomePage

  //check if the person is still logged in, based on that go to the right screen (fetch the week data in any case)
  //if refresh token is not expired, use it to get another refresh token --> still logged 
  void _checkLogin(BuildContext context) async {
    final result = await Impact.refreshTokens();
    final provider = Provider.of<DataProvider>(context, listen: false);
    DateTime day = DateTime.now(); 

    //il he's logged: get data of the past week and go to the home page
    if (result == 200) {
      //shows week data from yesterday up to 7 days before 
      await provider.getDataFromWeek(day); 
      _toHomePage(context);

    //if not, go to the login page (there: if credentials are correct --> get tokens --> go to loading page--> go to home page )       
    } else {
      _toLoginPage(context);
    }
  } //_checkLogin 

  @override
  Widget build(BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () => _checkLogin(context));
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset(
                'assets/logo_provvisorio.png',
                scale: 4),
                SizedBox(height:40),
                //animation for loading instead of "CircularProgressorIndicator"
                const LoadingAnimation(),
                SizedBox(height: 40),
                //shows some short expression telling the user to wait and be patient 
                const RotatingText()
              ]
            ),
        ),
      );
    } 
 }

