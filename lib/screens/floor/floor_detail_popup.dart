import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovar/blocs/CartBloc.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:inovar/models/floor.dart';
import 'package:inovar/screens/floor/add_to_cart_sheet.dart';
import 'package:inovar/screens/floor/inherited_floor_provider.dart';
import 'package:panorama/panorama.dart';

class FloorPopup extends StatefulWidget {
  @override
  _FloorPopupState createState() => _FloorPopupState();
}

class _FloorPopupState extends State<FloorPopup> {
  // ignore: close_sinks
  FloorBloc floorBloc;

  @override
  void initState() {
    super.initState();
    floorBloc = BlocProvider.of<FloorBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      content: Stack(
        overflow: Overflow.visible,
        children: [
          PopupContent(),
          PopupActions(),
        ],
      ),
    );
  }
}

class PopupActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Floor floor = InheritedFloor.of(context).floor;

    return Positioned(
        right: 5.0,
        top: 2.0,
        child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10.0,
            children: [
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => CartBloc(floor: floor),
                        child: AddToCart(floor: floor),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Container(
                      child: Text('Add to Cart'),
                      margin: EdgeInsets.only(right: 3.0),
                    ),
                    Icon(Icons.add_shopping_cart),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                child: InkResponse(
                  child: Icon(Icons.close),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]));
  }
}

class PopupContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      width: 700,
      child: Column(children: [
        PopupTitle(),
        PopupBody(),
      ]),
    );
  }
}

class PopupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(children: [
        PopupPictures(),
        PopupAccessories(),
      ]),
    );
  }
}

class PopupPictures extends StatefulWidget {
  @override
  _PopupPicturesState createState() => _PopupPicturesState();
}

class _PopupPicturesState extends State<PopupPictures> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onLeftButtonTapped() {
    _pageController.previousPage(
        curve: Curves.easeOutExpo, duration: Duration(seconds: 1));
  }

  void _onRightButtonTapped() {
    _pageController.nextPage(
        curve: Curves.easeOutExpo, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    Floor floor = InheritedFloor.of(context).floor;

    return Container(
      height: 300,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: 40.0,
                height: 300,
                child: Icon(Icons.arrow_left),
              ),
              onTap: () => _onLeftButtonTapped(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            Container(
              width: 350,
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: floor.panoramicImages.map((panoramicImage) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      width: 500,
                      height: 500,
                      child: ClipRect(
                        child: Panorama(
                          child: Image.asset(panoramicImage),
                        ),
                      ));
                }).toList(),
              ),
            ),
            InkWell(
              child: Container(
                width: 40.0,
                height: 300,
                child: Icon(Icons.arrow_right),
              ),
              onTap: () => _onRightButtonTapped(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ]),
    );
  }
}

class PopupAccessories extends StatefulWidget {
  @override
  _PopupAccessoriesState createState() => _PopupAccessoriesState();
}

class _PopupAccessoriesState extends State<PopupAccessories> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text('Accessories here!!!!!!!'),
    );
  }
}


class PopupTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Floor floor = InheritedFloor.of(context).floor;

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(13.0, 5.0, 0.0, 10.0),
      child: Text(
        floor.name,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
