import 'package:flutter/material.dart';
import 'app_const.dart';
import 'data/chain_info.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CoinDetailPage extends StatefulWidget {

  final String coinName;
  CoinDetailPage(this.coinName);

  @override
  State createState() {
    return new _CoinDetailPage(coinName);
  }
}

class _CoinDetailPage extends State<CoinDetailPage> {

  String coinName;
  int blockNum = 0;
  List<Widget> list = [];
  _CoinDetailPage(this.coinName);

  @override
  Widget build(BuildContext context) {
    String ico = 'https://i.mickle.tech/test/' + coinName + '.png';
    return Scaffold(
      appBar: new AppBar(title: new Text(coinName.toUpperCase() + " 节点信息"),
        leading: new Image.network(ico, width: 20, height: 20,),
      ),
      body: Center(child: new ListView(
        itemExtent: 50,
      children: ListTile.divideTiles(context: context, tiles: list)
          .toList(),),),);
  }

  void updateList(){
    list = <Widget>[
      new InfoItem('最新块高', blockNum.toString(),),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    updateList();
    super.initState();

    initData();
  }

  void initData(){
    switch(coinName){
      case coin_name_btc:
        break;
      case coin_name_eth:
        break;
      case coin_name_eos:
        getEOSInfo(refreshEOS);
        break;
    }
  }

  void refreshEOS(Response response){
    Map<String, dynamic> map = json.decode(response.body);

    if (this.mounted){
      setState(() {
        blockNum = map['head_block_num'];
        updateList();
      });
    }
  }
}

class InfoItem extends StatefulWidget{

  String name;
  String value;
  InfoItem(this.name, this.value);

  @override
  State createState() {
    return new _InfoItem(name, value);
  }

}

class _InfoItem extends State<InfoItem> {

  String name;
  String value;
  _InfoItem(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(margin: EdgeInsets.only(left: 20, right: 20), child:Text(name, textAlign: TextAlign.start, style: TextStyle(fontSize: 20),),),
        Container(margin: EdgeInsets.only(left: 20, right: 20), child:Text(value, textAlign: TextAlign.end, style: TextStyle(fontSize: 20),),),
      ],
    );
  }

}
