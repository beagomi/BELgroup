import 'package:flutter/material.dart';
import 'package:my_project/screens/home.dart';
import 'package:my_project/screens/home_widgets/loading_animation.dart';
import 'package:my_project/screens/home_widgets/rotatingText.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false); // Ottieni l'istanza del provider senza ascoltare i cambiamenti
    final DateTime day = DateTime.now(); // Suppongo che tu voglia caricare i dati per oggi

    // Effettua la chiamata per caricare i dati
    Future<void> loadData() async {
      await dataProvider.getDataFromWeek(day);
      // Una volta completato il caricamento, naviga alla schermata Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }

    // Chiamare loadData() all'avvio della schermata di caricamento
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

