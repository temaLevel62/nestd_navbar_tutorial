import 'package:flutter/material.dart';

import '../sliding_nav_bar/nav_bar_page_config.dart';

class CounterPageMenu extends StatefulWidget {
  final NavBarPageConfig menuItem;
  final int pageN;

  const CounterPageMenu({Key? key, required this.menuItem, required this.pageN})
      : super(key: key);

  @override
  State<CounterPageMenu> createState() => _CounterPageMenuState();
}

class _CounterPageMenuState extends State<CounterPageMenu>
    with AutomaticKeepAliveClientMixin<CounterPageMenu> {
  int i = 0;
  int j = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter page ${widget.pageN}',
        ),
        leading: Navigator.of(context, rootNavigator: false).canPop()
            ? IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: false).pop();
                },
                icon: const Icon(Icons.arrow_back))
            : null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: () => Navigator.of(context, rootNavigator: false)
                      .push(MaterialPageRoute(
                          builder: (context) => CounterPageMenu(
                              menuItem: widget.menuItem,
                              pageN: widget.pageN + 1))),
                  icon: const Icon(Icons.navigate_next),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    if (Navigator.of(context, rootNavigator: false).canPop()) {
                      Navigator.of(context, rootNavigator: false).pop();
                      //Add some comment
                    }
                  },
                  icon: const Icon(Icons.navigate_before),
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () => setState(() {
                    ModalRoute.of(context)
                        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
                      setState(() {
                        j = j - 1;
                      });
                    }));
                    setState(() {
                      j = j + 1;
                    });
                  }),
                  icon: const Icon(Icons.navigate_next),
                ),
              ],
            ),
            Text(
              '$j.$i',
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: () => setState(() {
                    i = i - 1;
                  }),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () => setState(() {
                    i = i + 1;
                  }),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
