import 'package:flutter/material.dart';
import './counter_tab/state_page_menu.dart';

import 'home_tab/home_menu.dart';
import 'sliding_nav_bar/nav_bar_page_config.dart';
import 'products_tab/products_menu.dart';
import 'profile_tab/profile_edit.dart';
import 'profile_tab/profile_menu.dart';
import 'sliding_nav_bar/nav_bar_root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuItemList = <NavBarPageConfig>[
      NavBarPageConfig(
          Icons.home,
          'Home',
          (menuItem) => HomeMenu(menuItem: menuItem, key: menuItem.key),
          Colors.red),
      NavBarPageConfig(
          Icons.shopping_basket,
          'Products',
          (menuItem) => ProductsMenu(menuItem: menuItem, key: menuItem.key),
          Colors.green),
      NavBarPageConfig(
          Icons.ice_skating,
          'Counter',
          (menuItem) => CounterPageMenu(
                menuItem: menuItem,
                key: menuItem.key,
                pageN: 0,
              ),
          Colors.yellow),
      NavBarPageConfig(
          Icons.person,
          'Me',
          (menuItem) => ProfileMenu(menuItem: menuItem, key: menuItem.key),
          Colors.blue),
    ];
    return MaterialApp(
        title: 'BottomNavbar Demo',
        //restorationScopeId: "SomeRestId",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        routes: {
          // This route needs to be registered, Because
          //  we are pushing this on the main Navigator Stack on line 754 (isRootNavigator:true)
          ProfileEdit.route: (context) => const ProfileEdit(),
        },
        home: NavBarRootScreen(menuItemList));
  }
}
