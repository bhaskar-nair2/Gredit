// The main editor page, most things and complications would reside here
import 'package:gredit/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    Firestore.instance
        .collection('docs')
        .document('$dats.id')
        .get()
        .then((DocumentSnapshot ds) {
      return ds.data;
    });

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
              child: PageMaker(docId: dats.id),
            )
          ],
        ),
      ),
    );
  }
}

class PageMaker extends StatelessWidget {
  const PageMaker({Key key, this.docId}) : super(key: key);

  final String docId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          Firestore.instance.collection('docs').document('$docId').snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
         int pageCount = int.parse(snapshot.data.data['totalPg'].toString());

        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        else
          return new ListView.builder(
            itemCount: pageCount,
            itemBuilder: (BuildContext context, index) {
              Map pgData = snapshot.data.data['page$index'];
              return new Page(
                pageData: pgData,
                docId: docId,
                index: index,
              );
            },
          );
      },
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key, this.pageData, this.docId, this.index}) : super(key: key);

  final Map pageData;
  final String docId;
  final num index;

  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
// text: widget.pageData.toString()
  final myController = TextEditingController();

  Future<void> _updateTaskValue(String text, num index) {
    Firestore().runTransaction((Transaction transaction) {
      Firestore.instance.collection('docs').document(widget.docId).setData({
        "page$index": {'text': text}
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController
        .addListener(() => _updateTaskValue(myController.text, widget.index));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: TextField(
          controller: myController,
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
          Icon(
            Icons.format_align_left,
            size: 20,
          ),
        ],
      ),
    );
  }
}
