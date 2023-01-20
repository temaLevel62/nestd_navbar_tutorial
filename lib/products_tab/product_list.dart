import 'package:flutter/material.dart';
import '../sliding_nav_bar/sliding_app_bar.dart';
import 'product_detail.dart';
import 'product_tile.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    //context.read<NavbarNotifier>().addScrollListener(_scrollController);
  }

  @override
  void dispose() {
    //_scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SlidingPrefSizedWidget(
          child: AppBar(title: const Text('Products')
          ),
        ),
        body: ListView.builder(
            //controller: _scrollController,
            itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: false).pushNamed(
                      ProductDetail.route,
                      arguments: {'id': index.toString()});
                },
                child: ProductTile(index: index)),
          );
        }),
      ),
    );
  }
}
