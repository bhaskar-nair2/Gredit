// Will contain the home page, i.e. files and add new all  that
import 'package:flutter/material.dart';
import 'package:gredit/screens/drawer.dart';
import 'package:gredit/screens/editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final docsRef = Firestore.instance.collection('docs');

abstract class ListItem {}

class DocCardData implements ListItem {
  String name;
  IconData icon;
  String id;
  String user;

  DocCardData(DocumentSnapshot data) {
    this.name = data['name'];
    this.id = data.documentID;
    this.user = data['user'];
    switch (data['type']) {
      case 'doc':
        this.icon = Icons.description;
        break;
      default:
        this.icon = Icons.insert_chart;
    }
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
          ),
          drawer: DashBoard(),
          body: GridMaker()),
    );
  }
}

class GridMaker extends StatelessWidget {
  const GridMaker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('docs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading');
          default:
            return GridView.count(
              padding: EdgeInsets.all(20),
              crossAxisCount: 2,
              children: snapshot.data.documents.map((DocumentSnapshot data) {
                return DocCard(data: DocCardData(data));
              }).toList(),
            );
        }
      },
    );
  }
}

class DocCard extends StatelessWidget {
  DocCard({Key key, this.data}) : super(key: key);

  final DocCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EditorPage.routeName,
            arguments: EditorData(data.name, data.id));
      },
      child: Card(
        child: Container(
          width: 200,
          height: 500,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  data.icon,
                  size: 54.0,
                  color: Colors.blue,
                ),
                Text(data.name),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    ));
  }
}

//  var gridView = GridView.builder(
//       padding: EdgeInsets.all(20),
//       gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//       itemCount: datList.length,
//       itemBuilder: (context, index) {
//         return DocCard(key: Key('$index'), data: datList[index]);
//       },
//     );
