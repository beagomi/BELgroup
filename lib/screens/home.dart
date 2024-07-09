import 'package:flutter/material.dart';
import 'package:my_project/screens/home_widgets/description.dart';
import 'package:my_project/screens/home_widgets/compute_index.dart';
import 'package:my_project/screens/home_widgets/line_graph.dart';
import 'package:my_project/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_project/screens/home_widgets/datesBis.dart';

//HOME PAGE WITH "HELLO, NOME UTENTE DELLE SP"
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = 'User'; // Nome di default

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _username = sp.getString('name') ?? 'User'; // Carica il nome salvato o utilizza un valore di default
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
                SizedBox(width: 10),
                Text(
                  '  Hello, $_username :)', // Mostra il nome caricato
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.indigo[600],
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Expanded(child: Container()), // Separatore
                IconButton(
                  icon: Icon(
                    Icons.supervised_user_circle_rounded,
                    color: Colors.indigo[600],
                    size: 40,
                  ),
                  onPressed: () async {
                    // go to the profile page and wait for the result 
                    final updatedUsername = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );

                    if (updatedUsername != null) {
                      setState(() {
                        _username = updatedUsername; // Update the name when you go back
                      });
                    }
                    else {
                      //set the default name "User" if data have been cancelled
                      _loadUsername();
                    }
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 30),
            
            //widgets created in the folder home_widgets
            DatesBis(),
            SizedBox(height: 20),
            Description(),
            LineGraph(),
            //Info(),
            ComputeIndex(), //questo è il bottone che se schiacciato passa alla schermata dell'indice
                            //una volta schiacciato dovrà anche prendere i dati del giorno coì appena mi si
                            //apre la schermata dell'indice avrò già i grafici aggiornati e tutto 
                            //(grazie al fatto che i grafici ascoltano perchè sono sotto un consumer del provider)
          ],
        ),
      ),
    );
  }
}
