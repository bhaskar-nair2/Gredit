// Will contain the home page, i.e. files and add new all  that
import 'package:flutter/material.dart';

import 'package:gredit/screens/drawer.dart';
import 'package:gredit/screens/editor.dart';

class DocCardData {
  final String name;
  final IconData icon;
  final String id;

  DocCardData(this.name, this.icon, this.id);
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
          body: GridView.count(
            padding: EdgeInsets.all(20),
            crossAxisCount: 2,
            children: List.generate(11, (index) {
              return DocCard(
                  data: DocCardData('Doc-1', Icons.domain,
                      '$index')); // Supply name and icon from here
            }),
          )),
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
                  color: Colors.red,
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
