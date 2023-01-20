import 'package:flutter/material.dart';

import '../sliding_nav_bar/nav_bar_page_config.dart';
import '../sliding_nav_bar/navbar_notifier.dart';
import 'profile_edit.dart';
import 'user_profile.dart';

class ProfileMenu extends StatefulWidget {
  final NavBarPageConfig menuItem;

  const ProfileMenu({Key? key, required this.menuItem}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}


class _ProfileMenuState extends State<ProfileMenu>
    with AutomaticKeepAliveClientMixin<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
        key: widget.menuItem.navigatorKey,
        initialRoute: '/',
        observers: [MyNavigatorObserver()],
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case ProfileEdit.route:
              builder = (BuildContext _) => const ProfileEdit();
              break;
            case "/":
            default: // implies "/"
              builder = (BuildContext _) => const UserProfile();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
