import 'package:flutter/material.dart';
import 'package:inovar/components/root_scaffold.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget title = Row(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
              child: Icon(Icons.store)),
          Text('Inovar')
        ]);

    final Widget content = Row(
      children: [
        Expanded(
            child: Text(
              'Welcome to the main screen',
              style: Theme.of(context).textTheme.headline1,
            ))
      ],
    );
    return RootScaffold(title, content);
  }
}