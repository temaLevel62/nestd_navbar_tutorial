import 'package:flutter/material.dart';

@immutable
class ProductComments extends StatelessWidget {
  final String id;

  //final _scrollController = ScrollController();

  const ProductComments({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail/comments';

  @override
  Widget build(BuildContext context) {
    //context.read<NavbarNotifier>().addScrollListener(_scrollController);
    return Scaffold(
      appBar: //SlidingPrefSizedWidget(
          //  child:
          AppBar(
        title: Text('Comments on Product $id'),
        //)
      ),
      body: ListView.builder(
          //controller: _scrollController,
          itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: ListTile(
              tileColor: Colors.grey.withOpacity(0.5),
              title: Text('Comment $index'),
            ),
          ),
        );
      }),
    );
  }
}
