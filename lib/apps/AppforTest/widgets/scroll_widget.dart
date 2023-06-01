import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              key: Key('item_$index'),
            );
          }),
    );
  }
}
