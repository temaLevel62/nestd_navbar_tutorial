import 'package:flutter/material.dart';

import 'product_comments.dart';

class ProductDetail extends StatelessWidget {
  final String id;
  const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $id'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('My AWESOME Product $id'),
          const Center(
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 300,
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: false).pushNamed(
                    ProductComments.route,
                    arguments: {'id': id.toString()});
              },
              child: const Text('show comments'))
        ],
      ),
    );
  }
}
