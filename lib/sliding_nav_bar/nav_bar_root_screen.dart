import 'package:flutter/material.dart';
import 'package:nestd_navbar_tutorial/sliding_nav_bar/sliding_app_bar.dart';
import 'package:provider/provider.dart';

import 'nav_bar_page_config.dart';
import 'navbar_notifier.dart';

class NavBarRootScreen extends StatefulWidget {
  final List<NavBarPageConfig> menuItemsList;

  const NavBarRootScreen(this.menuItemsList, {Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<NavBarRootScreen> createState() => _NavBarRootScreenState();
}

class _NavBarRootScreenState extends State<NavBarRootScreen>
    with SingleTickerProviderStateMixin {
  late final List<NavBarPageConfig> menuItems;
  late final NavbarVisibilitySuperviser _navbarNotifier;
  late final BackButtonNotifier _backButtonNotifier;

  @override
  void initState() {
    super.initState();
    menuItems = widget.menuItemsList;
    _navbarNotifier = NavbarVisibilitySuperviser();
    _backButtonNotifier = BackButtonNotifier(
        widget.menuItemsList.map((e) => e.navigatorKey).toList());
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight, right: 2, left: 2),
        content: Text('Tap back button again to exit'),
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  void dispose() {
    //_controller.dispose();
    _pageViewController.dispose();
    super.dispose();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isExitingApp =
            _backButtonNotifier.onBackButtonPressedTryMakeNestedPop();
        if (isExitingApp) {
          newTime = DateTime.now();
          int difference = newTime.difference(oldTime).inMilliseconds;
          oldTime = newTime;
          if (difference < 1000) {
            hideSnackBar();
            return isExitingApp;
          } else {
            showSnackBar();
            return false;
          }
        } else {
          return isExitingApp;
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<NavbarVisibilitySuperviser>.value(
              value: _navbarNotifier),
          ChangeNotifierProvider<BackButtonNotifier>.value(
              value: _backButtonNotifier),
        ],
        child: Material(
          child: Consumer<BackButtonNotifier>(
            builder: (context, _, __) =>
                Consumer<NavbarVisibilitySuperviser>(builder: (context, _, __) {
              return Scaffold(
                  body: SafeArea(
                    top: false,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _navbarNotifier.onScrollNotification,
                      child: PageView(
                        controller: _pageViewController,
                        onPageChanged: (index) {
                          if (_backButtonNotifier.index != index) {
                            _backButtonNotifier.index = index;
                            //final navBarNotifier = context.read<NavbarNotifier>();
                            _navbarNotifier.hideBottomNavBar = false;
                          }
                        },
                        children: menuItems
                            .map((item) => Theme(
                                data: ThemeData(
                                    colorScheme: Theme.of(context)
                                        .colorScheme
                                        .copyWith(primary: item.color)),
                                child: item.menuPage))
                            .toList(),
                      ),
                    ),
                  ),
                  bottomNavigationBar: SlidingBar(child: getNavBar()));
            }),
          ),
        ),
      ),
    );
  }

  Widget getNavBar() {
    final index = _backButtonNotifier.index;
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: index,
      onTap: (index) {
        if (_backButtonNotifier.index == index) {
          _backButtonNotifier.popAllRoutes(index);
        } else {
          _backButtonNotifier.index = index;
          _pageViewController.animateToPage(index,
              duration: kThemeAnimationDuration, curve: Curves.bounceOut);
        }
      },
      //elevation: 16.0,
      //showUnselectedLabels: true,
      //unselectedItemColor: Colors.white54,
      //selectedItemColor: Colors.white,
      items: menuItems
          .map((NavBarPageConfig menuItem) => BottomNavigationBarItem(
                backgroundColor: menuItems[index].color,
                icon: Icon(menuItem.iconData),
                label: menuItem.text,
              ))
          .toList(),
    );
  }
}
