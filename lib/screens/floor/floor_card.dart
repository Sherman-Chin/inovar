import 'package:flutter/material.dart';

class FloorCard extends StatelessWidget {
  final String floorName;
  final String floorDescription;
  final String imageName;

  FloorCard({this.floorName, this.floorDescription, this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
      child: Stack(
        children: [
          FloorCardContent(
            floorName: floorName,
            floorDescription: floorDescription,
          ),
          FloorThumbnail(imageName: imageName),
        ],
      ),
    );
  }
}

class FloorThumbnail extends StatelessWidget {
  final String imageName;

  FloorThumbnail({this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
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
          backgroundImage: AssetImage(imageName),
          radius: 50,
          child: InkWell(
            onTap: () => {},
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
    );
  }
}

class FloorCardContent extends StatelessWidget {
  final String floorName;
  final String floorDescription;

  FloorCardContent({this.floorName, this.floorDescription});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => {},
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
                floorName,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                floorDescription,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
