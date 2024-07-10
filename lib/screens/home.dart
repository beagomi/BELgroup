import 'package:flutter/material.dart';
import 'package:my_project/screens/home_widgets/description.dart';
import 'package:my_project/screens/home_widgets/compute_index.dart';
import 'package:my_project/screens/home_widgets/line_graph.dart';
import 'package:my_project/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_project/screens/home_widgets/datesBis.dart';

//HOME PAGE WITH "HELLO, *NOME UTENTE DELLE SP*" AND PROFILE ICON: if the user added a nickname he's called using that, 
//otherwise it's "hello user"

//stateful to manage the state of the nickname 
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = 'User'; // default name 

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _username = sp.getString('name') ?? 'User'; // uploads the name saved in SP if present otherwise uses the default name ("user")
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Container(
        padding: const EdgeInsets.only(top: 90),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  '  Hello, $_username :)', // shows the username (user or nickname, based on the SP)
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.indigo[600],
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Expanded(child: Container()), 
                IconButton(
                  icon: Icon(
                    Icons.supervised_user_circle_rounded,
                    color: Colors.indigo[600],
                    size: 40,
                  ),
                  onPressed: () async {
                    // go to the profile page and wait for the result (the user could change the nickname, so we need to adjust it)
                    final updatedUsername = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );

                    if (updatedUsername != null) {
                      setState(() {
                        _username = updatedUsername; // Update the name when you go back (the user could change it)
                      });
                    }
                    else {
                      //set the default name "User" if data have been cancelled
                      _loadUsername();
                    }
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 30),
            
            //widgets created in the folder home_widgets
            //clickable dates box: if clicked they lead to index page
            const DatesBis(),
            const SizedBox(height: 20),
            //small description of the following graph + CircularProgressIndicator if the data is loading
            const Description(),
            //shows weekly trend of rest index 
            const LineGraph(),
            //button that, if pressed, leads to the index page where index of today and its widgets are shown
            const ComputeIndex(), 
          ],
        ),
      ),
    );
  }
}
