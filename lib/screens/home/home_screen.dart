import 'package:flutter/material.dart';
import 'package:inovar/components/root_scaffold.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget title = Row(children: [Text('Inovar-logo'), Text('Inovar')]);

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