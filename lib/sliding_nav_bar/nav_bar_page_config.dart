import 'package:flutter/material.dart';

class NavBarPageConfig {
  NavBarPageConfig(this.iconData, this.text,
      //Widget Function(GlobalKey<NavigatorState>) getWidget, this.color) {
      Widget Function(NavBarPageConfig) getWidget, this.color):
      key = ValueKey(text){
    menuPage = getWidget(this);
  }

  final Color color;
  final IconData iconData;
  final String text;
  late final Widget menuPage;
  final navigatorKey = GlobalKey<NavigatorState>();
  final ValueKey<String> key;

}
