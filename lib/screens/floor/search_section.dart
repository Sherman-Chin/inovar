import 'package:flutter/material.dart';
import 'package:inovar/blocs/FloorBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSection extends StatefulWidget {
  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _controller = TextEditingController();
  Bloc floorBloc;
  List<bool> _isOpen = [false, false];

  @override
  void initState() {
    super.initState();
    floorBloc = BlocProvider.of<FloorBloc>(context);
  }

  void _updateList(i) {
    _isOpen[i] = !_isOpen[i];
    for (int j = 0; j < _isOpen.length; j++) {
      if (i != j) {
        _isOpen[j] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(17.0, 0, 17.0, 17.0),
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 240,
            child: TextField(
              onEditingComplete: () {
                print(_controller.text);
              },
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.all(5.0),
            children: [
              ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Category',
                          style: TextStyle(
                            color: Color(0xFFA45F66),
                            fontSize: 18.0,
                          )),
                    );
                  },
                  body: CategoryList(),
                  isExpanded: _isOpen[0]),
              ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Tag',
                          style: TextStyle(
                            color: Color(0xFFA45F66),
                            fontSize: 18.0,
                          )),
                    );
                  },
                  body: TagList(),
                  isExpanded: _isOpen[1]),
            ],
            expansionCallback: (i, isOpen) => setState(() {
              _updateList(i);
            }),
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      child: Column(
        children: [
          CheckboxListTile(
              value: _value,
              title: Text('Category 1'),
              onChanged: (value) => setState(() => {
                _value = value
              }),
          )
        ],
      ),
    );
  }
}

class TagList extends StatefulWidget {
  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  @override
  Widget build(BuildContext context) {
    return Text('Hello');
  }
}