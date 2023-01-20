import 'package:flutter/material.dart';

import '../sliding_nav_bar/sliding_app_bar.dart';
import 'feed_detail.dart';
import 'feed_tile.dart';

class HomeFeeds extends StatefulWidget {
  const HomeFeeds({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<HomeFeeds> createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SlidingPrefSizedWidget(
          child: AppBar(
        title: const Text('Feeds'),
      )),
      body: ListView.builder(
        //controller: _scrollController,
        itemCount: 30,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                //context.read<NavbarNotifier>().hideBottomNavBar = false;
                Navigator.of(context, rootNavigator: false).pushNamed(
                    FeedDetail.route,
                    arguments: {'id': index.toString()});
              },
              child: FeedTile(index: index));
        },
      ),
    );
  }
}
