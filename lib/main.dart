import 'package:flutter/material.dart';
import 'package:my_project/screens/splash.dart';
import 'package:my_project/utils/data_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(
            background: const Color(0xFFFFFFFF),
            primary:  const Color.fromARGB(255, 119, 133, 199),
            secondary: const Color(0xFFedf1f1),
            seedColor: const Color.fromARGB(255, 119, 133, 199)),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}


//nelle shared preferences salvo solo cose tipo TOKEN (!!!!)-> fondamentale perchè vogliamo che quando l'user si autentica
//la prima volta, poi non richieda di nuovo di accedere. 
//poi salvo cose tipo nome utente, data di nascita, ma non posso salvare dati interi tipo listone o cose così 

//if result = 200 -> login,
//se no: MOSTRA ALL'UTENTE CHE LE ROBE SONO SBAGLIATE !! IMPORTANTE PER L'ESAME

//aggiungi possibilità di fare log out (vedi pollutrack, li lo fanno) !!!


//INTRODUCTION SCREEN or PAGE_FLIP_BUILDER su flutter gems PER FARE SCHERMATE INIZIALI CHE SLITTANO 

//homeprovider: serve per settare i dati e la logica della home page
//schermate api sono per il loro provider dell'inquinamento 

//cerca di pensare a tutte le cose che potrebbero andare male 
//perchè il prof cerca di spaccare l'app (tipo: l'utente non vuole inserire un dato e l'app non sa come gestire questa cosa)

//si possono inserire le GIF????