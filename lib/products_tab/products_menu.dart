import 'package:flutter/material.dart';

import '../sliding_nav_bar/my_navigator_observer.dart';
import '../sliding_nav_bar/nav_bar_page_config.dart';
import 'product_comments.dart';
import 'product_detail.dart';
import 'product_list.dart';

class ProductsMenu extends StatefulWidget {
  final NavBarPageConfig menuItem;

  const ProductsMenu({Key? key, required this.menuItem}) : super(key: key);

  @override
  State<ProductsMenu> createState() => _ProductsMenuState();
}

class _ProductsMenuState extends State<ProductsMenu>
    with AutomaticKeepAliveClientMixin<ProductsMenu>
{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
        //restorationScopeId: "SomeRestId",
        key: widget.menuItem.navigatorKey,
        initialRoute: '/',
        observers: [MyNavigatorObserver()],
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case ProductDetail.route:
              final id = (settings.arguments as Map)['id'];
              builder = (BuildContext _) {
                return ProductDetail(
                  id: id,
                );
              };
              break;
            case ProductComments.route:
              final id = (settings.arguments as Map)['id'];
              builder = (BuildContext _) {
                return ProductComments(
                  id: id,
                );
              };
              break;
            case '/':
            default:
              builder = (BuildContext _) => const ProductList();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        });
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
