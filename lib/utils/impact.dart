import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/intl.dart';

class DayData {
    late final List<double> hrList;  //list of fc every 5 seconds
    late final double fcRest; //fc at rest 
    late final double sleepEff; //sleep efficiency 
    List<Map<String, dynamic>> exercisesOfDay; //all the exercises of the day

    DayData({required this.exercisesOfDay, required this.sleepEff, required this.fcRest, required this.hrList});
  } //DayData --> what is returned from "getDataFromDay"


class Impact{

  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static String pingEndpoint = 'gate/v1/ping/';
  static String tokenEndpoint = 'gate/v1/token/';
  static String refreshEndpoint = 'gate/v1/refresh/';
  static String patientUsername = 'Jpefaq6m58';
    
  static String sleepEndpoint = 'data/v1/sleep/patients/';
  static String exerciseEndpoint = 'data/v1/exercise/patients/';
  static String fcRestEndpoint = 'data/v1/resting_heart_rate/patients/';
  static String hrEndpoint = 'data/v1/heart_rate/patients/';


  //METHODS
    
    //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> getAndStoreTokens(String username, String password) async {
    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);

    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens


    //This method allows to refresh the stored JWT in SharedPreferences
    static Future<int> refreshTokens() async {
    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    if (refresh != null) {
      final body = {'refresh': refresh};

      //Get the response
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      //If the response is OK, set the tokens in SharedPreferences to the new values
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        await sp.setString('access', decodedResponse['access']);
        await sp.setString('refresh', decodedResponse['refresh']);
      } //if

      //Just return the status code
      return response.statusCode;
    }
    return 401;
  } //_refreshTokens


//This method checks if the saved token is still valid:
//if the token doesn't exist, returns FALSE
//if it exists, it tries to see if it is valid using Impact.checkToken
//if it is valid, returns TRUE
//if it is not, it returns false

  Future<bool> checkSavedToken({bool refresh = false}) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(refresh ? 'refresh' : 'access');

    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return Impact.checkToken(token);
    } catch (_) {
      return false;
    }
  }//_checkSavedTokens

  //used in checkSavedTokens
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }
    return true;
    
  } //_checkToken
  

  //checks if the user is authorized (if the username and password are valid)
  //obtains the JWT token pair from IMPACT and stores it in SharedPreferences
  static Future<int?> authorize() async {
    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final sp = await SharedPreferences.getInstance();
    final username = sp.getString('username');
    final password = sp.getString('password');

    if (username == null || password == null) {
        // Handle the null case
        print('Username or password is null');
        return null;  
    }

    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body); 

    //If 200, set the token
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_authorize


//This method prepares the Bearer header for the calls
  Future<Map<String, String>> getBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('access');

    return {'Authorization': 'Bearer $token'};
  }//_getBearer


//metodo per prendere i dati del giorno 
///SLEEP --> efficiency: 1 entrata/giorno
//ALLENAMENTO --> average heart rate, active calories, total duration: 3 entrate per ogni allenamento del giorno (anche più di uno)
//FC RIPOSO --> solo un valore e noi prendiamo quello: 1 entrata/giorno
//HEART RATE --> 1 valore ogni 5 secondi, li prendiamo tutti e poi ne tiriamo fuori HRV
  
//function to get the data of the day of interest
  static Future<DayData> getDataFromDay(DateTime day) async {
    //format the DateTime to a String in 'YYYY-MM-DD' format
    final String formattedDay = DateFormat('yyyy-MM-dd').format(day);

    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');
    var refresh = sp.getString('refresh');


    //checks if the access token is expired 
    if(JwtDecoder.isExpired(access!)){
      await Impact.refreshTokens();
      access = sp.getString('access');
    } //if

    //to manage if the refresh token is expired 
      if(JwtDecoder.isExpired(refresh!)) {
      await Impact.authorize(); //gets and stores tokens in the SP
      access = sp.getString('access');
      refresh = sp.getString('refresh');
    } //if


    //SLEEP REQUEST --> output: sleepEff (double)
    final urlSleep = Impact.baseUrl + Impact.sleepEndpoint + Impact.patientUsername + '/day/$formattedDay/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'}; 

    print('Calling : $urlSleep');
    final responseSleep = await http.get(Uri.parse(urlSleep), headers: headers);
    print(responseSleep.statusCode);

    //if ok parse the response using jsonDecoder, otherwise return null
    var resultS = null;
    print('sleep eff is:');
    var sleepEff = 75.0; //if day has no data, sleep eff is set to an average value (can go from 50 to 100), otherwise this value is overwritten with the real one
    if (responseSleep.statusCode == 200) {
      resultS = jsonDecode(responseSleep.body);
      //if there is data regarding sleep, save the sleep efficiency 
      if (resultS != null &&
        resultS['data'] != null &&
        resultS['data'] is Map &&
        resultS['data']['data'] != null &&
        resultS['data']['data'] is List &&
        resultS['data']['data'].isNotEmpty &&
        resultS['data']['data'][0] != null) {
          var sleepData = resultS['data']['data'];
          // Check if the first element has 'efficiency' and it is not null
          if (sleepData[0]['efficiency'] != null) {
            sleepEff = sleepData[0]['efficiency'].toDouble();
            }
          }
    }

    //EXERCISE REQUEST --> output: exerciseType (string), hrExercise (double), calExercise (double), durationExercise (double)
    final urlExercise = Impact.baseUrl + Impact.exerciseEndpoint + Impact.patientUsername + '/day/$formattedDay/';

    print('Calling : $urlExercise');
    final responseExercise = await http.get(Uri.parse(urlExercise), headers: headers);
    print(responseExercise.statusCode);

    //if ok parse the response using jsonDecoder, otherwise return null
    var resultE = null;

    List<Map<String, dynamic>> exercisesOfDay = [];
    if (responseExercise.statusCode == 200) {
      resultE = jsonDecode(responseExercise.body);

      //if there are data, iter inside ActivityType (can be more than one) and save them into a list
      if (resultE['data'].isNotEmpty) {
      List<dynamic> activities = resultE['data']['data'];

      activities.forEach((activity) {
        String activityType = activity['activityName'];
        double averageHR = activity['averageHeartRate'].toDouble();
        double calories = activity['calories'].toDouble();
        double duration = activity['duration'].toDouble();

        //create the map corresponding to this iteration (if I have one run and one walk I will have two maps)
        Map<String, dynamic> activityMap = {
            'exerciseType': activityType,
            'hr': averageHR,
            'cal': calories,
            'duration': duration,
          };
        exercisesOfDay.add(activityMap);
      }); //for
      } 

      //if no activities in the day
      else {
        Map<String, dynamic> activityMap = {
            'exerciseType': 'rest',
            'hr': 0.0,
            'cal': 0.0,
            'duration': 0.0,
          };
          exercisesOfDay.add(activityMap);
      }
      print('exercises of day are $exercisesOfDay');
    } //if 


    //FC RIPOSO REQUEST --> output: fcRest (double)
    final urlFcR = Impact.baseUrl + Impact.fcRestEndpoint + Impact.patientUsername + '/day/$formattedDay/';

    print('Calling : $urlFcR');
    final responseFcR = await http.get(Uri.parse(urlFcR), headers: headers);
    print(responseFcR.statusCode);

    //if ok parse the response using jsonDecoder, otherwise return null
    var resultFcR = null;
    var fcRest = 70.0; //set to the average value for healty subjects (range between 40 and 100)
    if (responseFcR.statusCode == 200) {
      resultFcR = jsonDecode(responseFcR.body);
      //print(resultFcR);
      //if there is data, save the fcRest
      //otherwise return fcRest = 0.0
      if (resultFcR != null && 
        resultFcR['data'] != null &&
        resultFcR['data']['data']!= null &&
        resultFcR['data']['data']['value'] != null ) {
          print(resultFcR);
          fcRest = resultFcR['data']['data']['value'].toDouble();
        }
    }

    //HR REQUEST --> output: hrList (list)
    final urlHR = Impact.baseUrl + Impact.hrEndpoint + Impact.patientUsername + '/day/$formattedDay/';

    print('Calling : $urlHR');
    final responseHR = await http.get(Uri.parse(urlHR), headers: headers);
    print(responseHR.statusCode);

    //if ok parse the response using jsonDecoder, otherwise return null
    var resultHR = null;
    List<double> hrList = [];

    if (responseHR.statusCode == 200) {
      print(responseHR.statusCode);
      resultHR = jsonDecode(responseHR.body);

      //iter through heart rates of the day without considering null values 
      if (resultHR != null && resultHR['data'] != null && resultHR['data']['data'] != null) {
      //iterando inserisco i valori in una lista
      List<dynamic> dataList = resultHR['data']['data'];
      for (var data in dataList) {
        if (data['value'] != null && data['value'] is num) {
          double value = (data['value'] as num).toDouble();
          hrList.add(value);
          }
        }
      } 
    }

    
    return DayData( 
      exercisesOfDay: exercisesOfDay,
      fcRest: fcRest, 
      sleepEff: sleepEff,
      hrList: hrList);


    } //_getDataFromDay
    

//function to get data from the last 7 days 
    static Future<List<DayData>> getDataFromWeek(DateTime day) async {
    final List<DayData> weekData = [];


    for (int i = 7; i >= 1; i--) { 
      final DateTime currentday = day.subtract(Duration(days: i));
      final DayData dayData = await getDataFromDay(currentday);
      weekData.add(dayData);
    }

    //returns a list containing all the data of the 7 previous day
    //now will be data starting from further day until those closer (day = 5 july --> list with data from 28 june to 4 july)
    return weekData;
    
}//_getDataFromWeek


  } //impact