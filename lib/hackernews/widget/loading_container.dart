import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Container(
            height: 24.0,
            width: 150.0,
            color: Colors.grey,
            margin: EdgeInsets.all(5.0),
          ),
          subtitle: Container(
            height: 24.0,
            width: 150.0,
            color: Colors.grey,
            margin: EdgeInsets.all(5.0),
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }
}
