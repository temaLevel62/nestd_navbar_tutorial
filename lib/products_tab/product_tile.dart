import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey.withOpacity(0.5),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 75,
              width: 75,
              color: Colors.grey,
            ),
            Text('Product $index'),
          ],
        ));
  }
}