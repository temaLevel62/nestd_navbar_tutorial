import 'package:flutter/material.dart';

class BackButtonAndCurrentIndexSupervisor extends ChangeNotifier {

  final List<GlobalKey<NavigatorState>> nestedNavigators;

  BackButtonAndCurrentIndexSupervisor(this.nestedNavigators);

  int _index = 0;

  int get index => _index;

  set index(int x) {
    bool needUpdate = _index != x;
    _index = x;

    if (needUpdate) notifyListeners();
  }

  // pop routes from the nested navigator stack and not the main stack
  // this is done based on the currentIndex of the bottom navbar
  // if the backButton is pressed on the initial route the app will be terminated
  bool onBackButtonPressedTryMakeNestedPop() {
    bool exitingApp = true;

    final navKey = nestedNavigators[index];
    if (navKey.currentState != null && navKey.currentState!.canPop()) {
      navKey.currentState!.pop();
      exitingApp = false;
      //navbarNotifier.hideBottomNavBar = false;
    }
    return exitingApp;
  }

  // pops all routes except first, if there are more than 1 route in each navigator stack
  void popAllRoutes(int index) {
    final navKey = nestedNavigators[index];
    if (navKey.currentState != null && navKey.currentState!.canPop()) {
      navKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
