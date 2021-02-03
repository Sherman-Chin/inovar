import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:inovar/screens/floor/floor_screen.dart';
import 'package:inovar/components/routes.dart';
import 'package:inovar/screens/home/home_screen.dart';
import 'package:inovar/services/floor_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeRoute().toString(),
      routes: {
        HomeRoute().toString(): (context) => HomeScreen(),
        FloorsRoute().toString(): (context) => BlocProvider(
              create: (context) =>
                  FloorBloc(floorDatabase: FloorDatabase.getInstance()),
              child: FloorScreen(),
            ),
      },
      title: 'Inovar',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
