import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:my_project/utils/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class DataProvider extends ChangeNotifier {
  List<double> hrList = [];
  double hrv = 0.0;
  //look at the calculateIndex function: these two (70, 75) are the values set if no data are provided
  //if there are data, these values will be overwritten with those of the day
  double fcRest = 70.0; 
  double sleepEff = 75.0;
  late String dob;
  late int age;
  List fcMeans = []; //will contain the mean fc of all exercise sessions of the day
  List cals = []; //will contain the calories of all exercise sessions of the day
  List durations = []; //will contain the durations of all exercise sessions of the day
  List types = []; //contains the strings of the type of exercise 
  double fcMean = 0.0;  //the mean of values of the fcMeans
  double cal = 0.0; //the sum of values of the calories
  double dur = 0.0; //the sum of values of the durations
  double intensity = 0.0;
  double index = 0.0;

  List<double> hrListIter = [];
  double hrvIter = 0.0;
  //look at the calculateIndex function: these two (70, 75) are the values set if no data are provided
  //if there are data, these values will be overwritten with those of the day
  double fcRestIter = 70.0;
  double sleepEffIter = 75.0;
  List fcMeansIter = [];
  List calsIter = [];
  List durationsIter = [];
  List typesIter = [];
  double intensityIter = 0.0;
  double indexIter = 0.0;
  List weekindex = [];

  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;

  //will be true if data is loading, false when loading in finished
  //useful to manage state of the widgets while data is loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  //function to update the dates for which data are fetched, used in datesBis in the homePage (arrows to go to previous or next 7 days)
  void updateDates(int days) {
    DateTime newStartDate = _startDate.add(Duration(days: days)); 
    DateTime today = DateTime.now();

    // Ensure the new start date is not in the future
    if (newStartDate.isAfter(today)) {
      //don't modify the graph
      return; 
    }
    _startDate = newStartDate;

    // Fetch data from the new start date
    getDataFromWeek(_startDate);
    notifyListeners();
  }

  //to manage if there are no data
  bool _hasData = true; 
  bool get hasData => _hasData;

  //function to get data from day
  Future<void> getDataFromDay(DateTime day) async {
    _isLoading = true;
    notifyListeners();
    
    final daydata = await Impact.getDataFromDay(day);

    if (daydata != null) {
      _hasData = true;
      //extract the HR list to compute HRV
      hrList = daydata.hrList;
      hrv = calculateHRV(hrList);  //uses the function created below to compute hrv

      //extract fcRest, will be used in the final index
      fcRest = daydata.fcRest;
      //extract sleepEff, will be used in the final index
      sleepEff = daydata.sleepEff;

      fcMeans.clear();
      cals.clear();
      durations.clear();
      types.clear();

      //manage more than one type of exercise per day
      for (var type in daydata.exercisesOfDay) {
        if (type.containsKey("hr")) {
          fcMeans.add(type["hr"]);
        }
        if (type.containsKey("cal")) {
          cals.add(type["cal"]);
        }
        if (type.containsKey("duration")) {
          durations.add(type["duration"]);
        }
        if (type.containsKey("exerciseType")) {
          types.add(type["exerciseType"]);
        }
      } 

      //if there are one or more activities in the day compute the intensity (otherwise intensity is 0)
      if (fcMeans.isNotEmpty && cals.isNotEmpty && durations.isNotEmpty) {
        intensity = await calculateIntensity(fcMeans, fcRest, cals, durations);
      } else {
        intensity = 0.0;
      }
      //print("intensity is $intensity");

      index = calculateIndex(hrv, fcRest, sleepEff, intensity);
      //print("index is $index");
      notifyListeners();
    } 
    else {
      _hasData = false;
    }
    _isLoading = false;
    notifyListeners();
  } //getDataFromDay


  //FUNCTION TO CALCULATE HRV 
  double calculateHRV(List<double> hrList) {
  List<double> intervals = hrList.map((bpm) => 60000 / bpm.toDouble()).toList(); //convert BPM in intervals of time between beats in ms
  double mean = intervals.reduce((a, b) => a + b) / intervals.length; //compute mean of intervals
  double sumOfSquares = intervals.map((interval) => pow(interval - mean, 2).toDouble()).reduce((a, b) => a + b); //compute sum of squared differences with the mean
  double hrv = sqrt(sumOfSquares / (intervals.length - 1)); //compute standard deviation (HRV)
  return hrv;
  } //calculateHRV 

  //FUNCTION TO CALCULATE INTENSITY OF TRAINING
  Future<double> calculateIntensity(List fcMeans, double fcRest, List cals, List durations) async {
    age = await calculateAge();
    double minCalIntensity = 2.5; //2.5 kcal per minute --> slow walk 
    double maxCalIntensity = 15;  //15 kcal per minute --> extremely high intensity run/cycling

    fcMean = (fcMeans.reduce((a,b) => a+b))/fcMeans.length; //mean of all fcMean of the exercises of day
    cal = (cals.reduce((a,b) => a+b)); //sum of all calories consumed of the exercises of day
    dur = (durations.reduce((a,b) => a+b))/60000; //sum of all durations of the exercises of day (in min instead of ms)
    //print("duration is $dur");

    int fcMax = 220 - age; //estimate of max fc

    //if dur != 0 means that there are exercises in that day (one at least)
    if (dur != 0) {
    double cardiacIntensity = ((fcMean - fcRest) / (fcMax - fcRest)) * 100; //KARVONEN FORMULATION
    double caloricIntensity = (((cal/dur) - minCalIntensity) / (maxCalIntensity - minCalIntensity) ) * 100;

    //print(cardiacIntensity);
    //print(caloricIntensity);

    double intensity = (cardiacIntensity + caloricIntensity) / 2; //total intensity

    return intensity;
    }
    else {
      return 0.0;
    }
  }

//FUNCTION TO GET DATE OF BIRTH FROM SHARED PREFERENCES AND TO COMPUTE THE AGE

Future<int> calculateAge() async {
  final prefs = await SharedPreferences.getInstance();
  String dob = prefs.getString('dob') ?? '';

  if (dob.isEmpty) {
    // manage the case in which dob is not given (impossible bc given at the first login)
    print("Date of birth not set");
    return 30; // age of the avarage user of the app
  }

  try {
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(dob);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // set the age if the birthday still has to arrive this year 
    if (today.month < birthDate.month || 
       (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  } catch (e) {
    //manage the ecception if the format is not valid
    print("Invalid date format: $dob");
    return -1; 
  }
}


  //function to normalize values in the index computation 
  double normalizeValue(double value, double min, double max) {
    return ((value - min) / (max - min)) * 100;
  }

  //FUNCTION TO COMPUTE THE FINAL REST INDEX 
  //the higher the index the faster will be the recovery
  //hrv, sleep efficiency: the higher the faster the recovery (the higher the index)
  //fcRest, intensity: the higher the slower the recovery (the lower the index)

  //the values are normalized based on some standard values for healty subjects found in literature 
  double calculateIndex(double hrv, double fcRest, double sleepEff, double intensity) {

    //fcRest was set to 0.0 if no data for the day --> subsitute with average value for healty person (70)
    if (fcRest == 0.0) {
      fcRest = 70.0;
    }
    //sleepEff was set to 0.0 if no data for the day --> substitute with average value (75)
    if (sleepEff == 0.0) {
      sleepEff = 75.0;
    }

    //range of values for healty subjects
    double normalizedHrv = normalizeValue(hrv, 20.0, 250.0);
    double normalizedFcRest = normalizeValue(fcRest, 40.0, 100.0);  
    double normalizedSleepEff = normalizeValue(sleepEff, 50.0, 100.0); 


    double total = normalizedHrv*0.2 + (100-normalizedFcRest)*0.2 + normalizedSleepEff*0.2 + (100-intensity)*0.4;
    return total;
  }

  //function to get data from week
  Future<void> getDataFromWeek(DateTime day) async {
    _startDate = day;
    _isLoading = true;
    notifyListeners();

    print("FETCHING DATA FROM WEEK STARTING FROM: $day");
    final weekdata = await Impact.getDataFromWeek(day);

    //reset before adding data from another week
    weekindex.clear();
      //for every day it computes the index, the index is added to the week list "weekindex"
      for (DayData day in weekdata) {
        //extract hr to compute HRV
        hrListIter = day.hrList;
        hrvIter = calculateHRV(hrListIter);

        //extract fcRest
        fcRestIter = day.fcRest;
        //extract sleep efficiency
        sleepEffIter = day.sleepEff;

        fcMeansIter.clear();
        calsIter.clear();
        durationsIter.clear();
        typesIter.clear();

        //manage more than one exercise type per day
        for (var type in day.exercisesOfDay) {
          if (type.containsKey("hr")) {
            fcMeansIter.add(type["hr"]);
          }
          if (type.containsKey("cal")) {
            calsIter.add(type["cal"]);
          }
          if (type.containsKey("duration")) {
            durationsIter.add(type["duration"]);
          }
          if (type.containsKey("exerciseType")) {
            typesIter.add(type["exerciseType"]);
          }
        } 
        if (fcMeansIter.isNotEmpty && calsIter.isNotEmpty && durationsIter.isNotEmpty) {
          intensityIter = await calculateIntensity(fcMeansIter, fcRestIter, calsIter, durationsIter);
          //print("INTENSITY ITER IS $intensityIter");
        }
        else {
          intensityIter = 0.0;
        }
        indexIter = calculateIndex(hrvIter, fcRestIter, sleepEffIter, intensityIter);
        if (indexIter.isNaN) {
          indexIter = 0;
        }
        weekindex.add(indexIter.round());
        //print("INDEX IS $indexIter");
      }
      print(weekindex);
      _isLoading = false;
      notifyListeners();
    
  } //getDataFromWeek
 
} //DataProvider
