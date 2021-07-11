import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/blocs/CategoryBloc.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:inovar/screens/floor/floor_screen.dart';
import 'package:inovar/screens/home/home_screen.dart';
import 'package:inovar/services/floor_repository.dart';
import 'package:inovar/services/routes.dart';

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
        FloorsRoute().toString(): (context) => MultiBlocProvider(
              providers: [
                BlocProvider<FloorBloc>(
                    create: (context) =>
                        FloorBloc(floorDatabase: FloorRepository())),
                BlocProvider<CategoryBloc>(
                    create: (context) =>
                        CategoryBloc(floorDatabase: FloorRepository())),
              ],
              child: FloorScreen(),
            ),
      },
      title: 'Inovar',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline3: TextStyle(color: Color(0xFFA45F66)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
