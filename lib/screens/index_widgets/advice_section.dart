import 'package:flutter/material.dart';

class AdviceSection extends StatelessWidget {
  final int computedIndex;

  const AdviceSection({Key? key, required this.computedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            'Here are some tips tailored for you right now:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'CustomFont',
            ),
          ),
        ),
        AdviceBox(computedIndex: computedIndex),
      ],
    );
  }
}

class AdviceBox extends StatelessWidget {
  final int computedIndex;

  const AdviceBox({Key? key, required this.computedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Advice> advices = _getAdvices(computedIndex);

  return Container(
      height: 400, // Altezza aumentata per i box
      child: PageView.builder(
        physics: const PageScrollPhysics(), // Disabilita lo scroll a metà
        pageSnapping: true, // Assicura che si sposti completamente a un riquadro alla volta
        itemCount: advices.length,
        itemBuilder: (context, index) {
          return _buildAdviceItem(context, advices[index]);
        },
      ),
    );
  }

  Widget _buildAdviceItem(BuildContext context, Advice advice) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // 80% della larghezza dello schermo
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: 250, // Altezza massima per l'immagine
            ),
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                advice.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              advice.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontFamily: 'CustomFont',
              ),
            ),
          ),
        ],
      ),
    );
  }



  List<Advice> _getAdvices(int index) {
    if (index <= 50) {
      return [
        Advice(imagePath: 'assets/dormita.JPG', text: "Give yourself the gift of a good night's sleep—it's nature's way of recharging your superpowers!  "),
        Advice(imagePath: 'assets/goodFood.JPG', text: "Feed your body the good stuff—it's like fueling up with premium for your personal engine!       "),
        Advice(imagePath: 'assets/relaxTechniques.JPG', text: "Find your zen zone—whether it's yoga, meditation, or just a quiet moment with your thoughts, recharge that mental battery!"),
        Advice(imagePath: 'assets/bevi.JPG', text: "Stay hydrated, stay fabulous! Water is your secret weapon against fatigue.                          "),
         Advice(imagePath: 'assets/massaggio.JPG', text: "Roll out the recovery red carpet with some self-care magic—massage or roll out those muscles to get your circulation grooving and tensions soothing!"),
      ];
    } else if (index <= 75) {
      return [
        Advice(imagePath: 'assets/stretch.JPG', text: "Give yourself a mini stretch break—it's like yoga for your mood and muscles!                     "),
        Advice(imagePath: 'assets/pleasure.JPG', text: "Take a mini mental vacation with your favorite treat!"),
        Advice(imagePath: 'assets/music.JPG', text: "Boost your mood with a playlist that hits all the right notes!"),
        Advice(imagePath: 'assets/breathsInNature.JPG', text: "Take a walk through nature to refresh your mind"),
        Advice(imagePath: 'assets/relax.JPG', text: "Relax by engaging in activities that bring you joy and fulfillment!"),
        
      ];
    } else {
      return [
        Advice(imagePath: 'assets/beer.JPG', text: "Keep your spirits high with friends—sharing a beer or a drink is a great way to unwind and feel good!"),
        Advice(imagePath: 'assets/active.JPG', text: "Keep movin'! Regular exercise boosts your physical health but also pumps up those feel-good vibes."),
        Advice(imagePath: 'assets/hobbie.JPG', text: "Maintain your energy by diving into activities that bring you joy and fulfillment."),
        Advice(imagePath: 'assets/goodSleep.JPG', text: "Keep your sleep game strong! Stick to a cozy bedtime routine and create a dreamy environment for those ZZZs."),
        Advice(imagePath: 'assets/stressManagement.JPG', text:  "Keep calm and meditate on! Practice yoga, deep breathing, or mindfulness to stay zen."),
      ];
    }
  }

  Widget _buildAdviceBox(Advice advice) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            advice.imagePath,
            width: 80,
            height: 80,
          ),
          SizedBox(height: 10),
          Text(
            advice.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Advice {
  final String imagePath;
  final String text;

  Advice({required this.imagePath, required this.text});
}
