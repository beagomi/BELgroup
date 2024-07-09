
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Info extends StatefulWidget {
  const Info({super.key});

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 216, 53),
        title: const Text(
          "Info on Rest Index",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'CustomFont',
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                InfoPage(
                  imagePath: 'assets/intro.JPG', // Replace this with your image path
                  title: 'Training and Rest',
                  sections: [
                    Section(
                      icon: MdiIcons.run,
                      text: 'Training and maintaining an active lifestyle are crucial, but rest is equally important.',
                    ),
                    Section(
                      icon: MdiIcons.bed,
                      text: 'Resting helps maximize the positive effects of exercise on the body and maintain a good physical and mental balance.',
                    ),
                    Section(
                      icon: MdiIcons.lightbulb,
                      text: 'Our index will be your companion throughout your life. If it is low, it means you need to rest. By following our advice, you will be able to restore your body\'s balance.',
                    ),
                  ],
                ),
                InfoPage(
                  imagePath: 'assets/train.JPG', // Replace this with your image path
                  title: 'Factors Influencing Rest Index',
                  sections: [
                    Section(
                      icon: MdiIcons.heart,
                      text: 'The lower your resting heart rate, the more trained you are to withstand stress and exertion.',
                    ),
                    Section(
                      icon: MdiIcons.chartLine,
                      text: 'HRV influences your ability to handle stress and exertion effectively.',
                    ),
                    Section(
                      icon: MdiIcons.fire,
                      text: 'The more calories you burn, the higher the intensity of the exercise.',
                    ),
                    Section(
                      icon: MdiIcons.sleep,
                      text: 'Poor sleep quality leads to greater fatigue after exercise.',
                    ),
                  ],
                ),
                InfoPage(
                  imagePath: 'assets/rest1.JPG', // Replace this with your image path
                  title: 'Tips for Optimal Recovery',
                  sections: [
                    Section(
                      icon: Icons.bed,
                      text: 'Discover how to improve your sleep for optimal recovery.',
                      ),
                    Section(
                      icon: Icons.food_bank,
                      text: 'Learn how to nourish yourself effectively to support recovery.',
                      ),
                    Section(
                      icon: Icons.self_improvement,
                      text: 'Explore techniques like stretching to aid in muscle recovery and relaxation.',
                      ),
                    ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    activeDotColor: Color.fromARGB(255, 253, 216, 53),
                    dotColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<Section> sections;

  const InfoPage({
    required this.imagePath,
    required this.title,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300, // Fixed height for images
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[600],
            ),
          ),
          const SizedBox(height: 10),
          ...sections.map((section) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(section.icon, color: Colors.indigo),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    section.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class Section {
  final IconData icon;
  final String text;

  Section({
    required this.icon,
    required this.text,
  });
}
