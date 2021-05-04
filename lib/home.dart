import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:routine/ui/clock/clock_view.dart';
import 'package:routine/ui/routine/routine_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  PageController _pageController;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    _changePage(int index) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          RoutineView(),
          ClockView(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _currentTab,
        height: 50.0,
        items: [
          Icon(Icons.local_drink, size: 30),
          Icon(Icons.timer, size: 30),
        ],
        color: Theme.of(context).bottomAppBarColor,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
          _changePage(_currentTab);
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
