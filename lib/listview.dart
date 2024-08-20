import 'package:flutter/material.dart';

class CustomsListView extends StatelessWidget {
  const CustomsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [];

    return SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
              ),
            );
          },
        ));
  }
}
