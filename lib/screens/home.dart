// Will contain the home page, i.e. files and add new all  that
import 'package:flutter/material.dart';
import 'package:gredit/screens/drawer.dart';
import 'package:gredit/screens/editor.dart';

abstract class ListItem {}

class DocCardData implements ListItem {
  final String name;
  final IconData icon;
  final String id;

  DocCardData(this.name, this.icon, this.id);
}

List datList = [
  DocCardData('Name', Icons.access_alarm, '1'),
  DocCardData('Fame', Icons.snooze, '2'),
  DocCardData('Game', Icons.account_circle, '3'),
  DocCardData('Lame', Icons.accessibility, '4'),
  DocCardData('Game', Icons.account_circle, '5'),
];

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
          body: GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: datList.length,
            itemBuilder: (context, index) {
              return DocCard(key: Key('$index'), data: datList[index]);
            },
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
