import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NavbarVisibilitySuperviser extends ChangeNotifier {
  NavbarVisibilitySuperviser();

  bool _hideBottomNavBar = false;

  bool get hideBottomNavBar => _hideBottomNavBar;

  set hideBottomNavBar(bool hide) {
    bool needUpdate = hide != _hideBottomNavBar;
    _hideBottomNavBar = hide;
    if (needUpdate) notifyListeners();
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification.depth == 1) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            hideBottomNavBar = false;
            break;
          case ScrollDirection.reverse:
            hideBottomNavBar = true;
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }
}

class BackButtonNotifier extends ChangeNotifier {
  //final MyNavbarNotifier navbarNotifier;
  final List<GlobalKey<NavigatorState>> nestedNavigators;

  BackButtonNotifier(this.nestedNavigators);

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

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final curRoute = previousRoute?.navigator?.context.read<NavbarVisibilitySuperviser>();
    curRoute?.hideBottomNavBar = false;
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final curRoute = previousRoute?.navigator?.context.read<NavbarVisibilitySuperviser>();

    curRoute?.hideBottomNavBar = false;
    super.didPush(route, previousRoute);
  }
}
