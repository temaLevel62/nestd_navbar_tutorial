import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navbar_visibility_supervisor.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final curRoute = previousRoute?.navigator?.context.read<NavbarVisibilitySupervisor>();
    curRoute?.hideBottomNavBar = false;
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final curRoute = previousRoute?.navigator?.context.read<NavbarVisibilitySupervisor>();

    curRoute?.hideBottomNavBar = false;
    super.didPush(route, previousRoute);
  }
}
