import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';

// Stateless Widget for Title
class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

// Stateful Widget for Welcome
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      'title': 'Welcome',
      'subtitle': 'Discover the latest recipes in our app',
      'image': 'assets/welcome1.png',
    },
    {
      'title': 'Stay Updated',
      'subtitle': 'Stay updated with our recipes.',
      'image': 'assets/welcome2.png',
    },
    {
      'title': 'Explore',
      'subtitle': 'Explore amazing recipes just for you.',
      'image': 'assets/welcome3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ConcentricPageView(
        pageController: _pageController,
        colors: const [
          Color(0xFFFFA726),
          Color(0xFFFFCC80),
          Colors.amber,
        ],
        radius: size.width * 0.5,
        itemCount: pages.length,
        itemBuilder: (int index) {
          final page = pages[index];
          return _buildPage(
            context: context,
            title: page['title']!,
            subtitle: page['subtitle']!,
            imagePath: page['image']!,
            isLastPage: index == pages.length - 1,
            currentIndex: index,
          );
        },
        onFinish: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    );
  }

  Widget _buildPage({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imagePath,
    required bool isLastPage,
    required int currentIndex,
  }) {
    final size = MediaQuery.of(context).size;
    final circleSize = size.width * 0.2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: size.height * 0.4,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.08,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size.width * 0.045,
            color: Colors.white70,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(
                isLastPage ? Icons.check : Icons.arrow_forward,
                size: circleSize * 0.5,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (isLastPage) {
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  _pageController.animateToPage(
                    currentIndex + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
