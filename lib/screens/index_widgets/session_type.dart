import 'package:flutter/material.dart';


//VECCHIO 
/*
class SessionType extends StatefulWidget {
  @override
  _SessionTypeState createState() => _SessionTypeState();
}

class _SessionTypeState extends State<SessionType> {
  final List<Map<String, dynamic>> _iconData = [
    {'icon': Icons.directions_run_rounded, 'label': 'Run'},
    {'icon': Icons.directions_bike_rounded, 'label': 'Bike'},
    {'icon': Icons.sports_soccer_rounded, 'label': 'Football'},
  ];

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    print('Initializing SessionType');
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextIcon() {
    setState(() {
      if (_currentIndex == _iconData.length - 1) {
        _currentIndex = 0;
      } else {
        _currentIndex++;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _previousIcon() {
    setState(() {
      if (_currentIndex == 0) {
        _currentIndex = _iconData.length - 1;
      } else {
        _currentIndex--;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building SessionType widget');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _iconData[_currentIndex]['label'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  iconSize: 20.0,
                  onPressed: _previousIcon,
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    Positioned(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _iconData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Icon(
                              _iconData[index]['icon'],
                              size: 40.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  iconSize: 20.0,
                  onPressed: _nextIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

*/
//NUOVO FUNZIONA!!!!

import 'package:provider/provider.dart';
import 'package:my_project/utils/data_provider.dart';

class SessionType extends StatefulWidget {
  @override
  _SessionTypeState createState() => _SessionTypeState();
}

class _SessionTypeState extends State<SessionType> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextIcon(int count) {
    setState(() {
      if (_currentIndex == count - 1) {
        _currentIndex = 0;
      } else {
        _currentIndex++;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _previousIcon(int count) {
    setState(() {
      if (_currentIndex == 0) {
        _currentIndex = count - 1;
      } else {
        _currentIndex--;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    var activities = dataProvider.types;

    if (activities.isEmpty) {
      activities = ['no_activity'];
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _getEnglishActivityName(activities[_currentIndex]),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  iconSize: 20.0,
                  onPressed: () => _previousIcon(activities.length),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    Positioned(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: activities.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Icon(
                              _getIconForActivity(activities[index]),
                              size: 40.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  iconSize: 20.0,
                  onPressed: () => _nextIcon(activities.length),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForActivity(String activity) {
    switch (activity.toLowerCase()) {
      case 'camminata':
        return Icons.directions_walk_rounded;
      case 'corsa':
        return Icons.directions_run_rounded;
      case 'bici':
        return Icons.directions_bike_rounded;
      case 'calcio':
        return Icons.sports_soccer_rounded;
      case 'nuoto':
        return Icons.pool_rounded;
      case 'sports':
        return Icons.sports_baseball_rounded;
      case 'basket':
        return Icons.sports_basketball_rounded;
      case 'no_activity':
        return Icons.bed_rounded;
      case 'rest':
        return Icons.bedtime_sharp;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _getEnglishActivityName(String activity) {
    switch (activity.toLowerCase()) {
      case 'camminata':
        return 'Walking';
      case 'corsa':
        return 'Running';
      case 'bici':
        return 'Cycling';
      case 'calcio':
        return 'Soccer';
      case 'nuoto':
        return 'Swimming';
      case 'sports':
        return 'Sports';
      case 'basket':
        return 'Basketball';
      case 'no_activity':
        return 'No Activity';
      case 'rest':
        return 'Rest';
      default:
        return 'Unknown Activity';
    }
  }
}
