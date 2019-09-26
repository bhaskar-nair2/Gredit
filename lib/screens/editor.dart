// The main editor page, most things and complications would reside here
import 'package:gredit/screens/drawer.dart';
import 'package:flutter/material.dart';

class EditorData {
  final String name;
  final String id;

  EditorData(this.name, this.id);
}

class EditorPage extends StatelessWidget {
  const EditorPage({Key key, EditorData data}) : super(key: key);

  static const routeName = '/editorPage';

  @override
  Widget build(BuildContext context) {
    final EditorData dats = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(dats.name),
      ),
      drawer: DashBoard(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            ControlBar(),
            DecoBar(),
            Expanded(
              child: ListView(
                children: List.generate(3, (index) {
                  return Page(); // Supply name and icon from here
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key}) : super(key: key);

  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: TextField(
          maxLines: 24,
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    ));
  }
}

class ControlBar extends StatefulWidget {
  ControlBar({Key key}) : super(key: key);

  _ControlBarState createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(Icons.message),
            Icon(Icons.highlight),
          ],
        ));
  }
}

class DecoBar extends StatefulWidget {
  DecoBar({Key key}) : super(key: key);

  _DecoBarState createState() => _DecoBarState();
}

class _DecoBarState extends State<DecoBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.format_align_left, size: 20,),
        ],
      ),
    );
  }
}
