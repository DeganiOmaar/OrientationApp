import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:orientation_app/lyceeScreens/sciencesScreens/math.dart';
import 'package:orientation_app/lyceeScreens/sciencesScreens/science.dart';
import 'package:orientation_app/lyceeScreens/sciencesScreens/technique.dart';

class HomeScience extends StatefulWidget {
  const HomeScience({super.key});

  @override
  State<HomeScience> createState() => _HomeScienceState();
}

class _HomeScienceState extends State<HomeScience> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4, top: 4, bottom: 4),
        child: GNav(
          gap: 6,
          color: Colors.grey,
          activeColor: Colors.indigo,
          curve: Curves.decelerate,
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 4),
          onTabChange: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              currentPage = index;
            });
          },
          tabs:  const [
            GButton(
              icon: FontAwesomeIcons.book,
              iconSize: 21,
              text: 'Science',
            ),
            GButton(
              icon: FontAwesomeIcons.calculator,
                 iconSize: 21,
              text: 'Math',
            ),
            GButton(
              icon: FontAwesomeIcons.wrench,
                 iconSize: 21,
              text: 'Technique',
            ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: (index) {},
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [Science(), Math(), Technique()],
      ),
    );
  }
}
