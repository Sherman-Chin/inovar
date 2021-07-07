import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:inovar/models/floor.dart';
import 'package:inovar/screens/floor/floor_detail_popup.dart';
import 'package:inovar/screens/floor/inherited_floor_provider.dart';

class FloorCard extends StatefulWidget {
  final double begin;
  final double end;

  FloorCard({@required this.begin, @required this.end});

  @override
  _FloorCardState createState() => _FloorCardState();
}

class _FloorCardState extends State<FloorCard> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> _fadeIn;

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(widget.begin, widget.end, curve: Curves.linear)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: _fadeIn,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Stack(
          children: [
            FloorCardContent(),
            FloorThumbnail(),
          ],
        ),
      ),
    );
  }
}

class FloorThumbnail extends StatelessWidget {
  // ignore: close_sinks
  FloorBloc floorBloc;

  FloorThumbnail();

  @override
  Widget build(BuildContext context) {
    floorBloc = BlocProvider.of<FloorBloc>(context);
    Floor floor = InheritedFloor.of(context).floor;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(-5.0, 0.0),
          ),
        ],
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        backgroundImage: AssetImage(floor.profileImage),
        radius: 50,
        child: InkWell(
          onTap: () => {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    BlocProvider<FloorBloc>.value(
                      value: floorBloc,
                      child: InheritedFloor(
                        floor: floor,
                        child: FloorPopup(),
                      ),
                    ))
          },
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class FloorCardContent extends StatelessWidget {
  // ignore: close_sinks
  FloorBloc floorBloc;

  FloorCardContent();

  @override
  Widget build(BuildContext context) {
    floorBloc = BlocProvider.of<FloorBloc>(context);
    Floor floor = InheritedFloor.of(context).floor;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) => BlocProvider<FloorBloc>.value(
                  value: floorBloc,
                  child: InheritedFloor(
                    floor: floor,
                    child: FloorPopup(),
                  ),
                ))
      },
      child: Container(
        margin: EdgeInsets.only(left: 50.0),
        width: 250,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                floor.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                floor.code,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
