import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavbarVisibilitySupervisor extends ChangeNotifier {
  NavbarVisibilitySupervisor();

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


