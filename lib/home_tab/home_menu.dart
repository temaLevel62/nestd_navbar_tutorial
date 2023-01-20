import 'package:flutter/material.dart';

import '../home_tab/feed_detail.dart';
import '../sliding_nav_bar/nav_bar_page_config.dart';
import '../sliding_nav_bar/navbar_notifier.dart';
import 'home_feed.dart';

class HomeMenu extends StatefulWidget {
  final NavBarPageConfig menuItem;

  const HomeMenu({Key? key, required this.menuItem}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu>
    with AutomaticKeepAliveClientMixin<HomeMenu> {
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
            case FeedDetail.route:
              builder = (BuildContext _) {
                final id = (settings.arguments as Map)['id'];
                return FeedDetail(
                  feedId: id,
                );
              };
              break;
            case '/':
            default:
              builder = (BuildContext _) => const HomeFeeds();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
