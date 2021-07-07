import 'package:flutter/material.dart';
import 'package:inovar/components/drawer.dart';

class RootScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;
  RootScaffold(this.title, this.body);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: body,
      drawer: SideDrawer(),
    );
  }
}
