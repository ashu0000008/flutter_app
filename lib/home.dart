import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
//    return ListView.builder(
//      padding: EdgeInsets.all(8.0),
//      itemExtent: 20.0,
//      itemCount: 3,
//      itemBuilder: (BuildContext context, int index) {
//        return Text('entry $index');
//      },
//    );

    return Scaffold(body: Center(child: ListView(children: ListTile.divideTiles(context: context, tiles: list).toList(),),),);
//    return Scaffold(body: Center(child: ListView(children: list,),),);
  }
}

List<Widget> list = <Widget>[
  ListTile(
    title: Text("BTC", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
    subtitle: Text("Bitcoin"),
    leading: Image.asset('lib/images/ic_at.png', width: 30, height: 30,),
  ),

  ListTile(
    title: Text("ETH", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
    subtitle: Text("Ethereum"),
    leading: Image.asset('lib/images/ic_at.png', width: 30, height: 30,),
  ),

  ListTile(
    title: Text("EOS", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
    subtitle: Text("EOS"),
    leading: Image.asset('lib/images/ic_at.png', width: 30, height: 30,),
  ),

];

