import 'package:flutter/material.dart';
import 'app_const.dart';
import 'page_coin_detail.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    List<Widget> list = <Widget>[
      ListTile(
        title: Text(
          "BTC", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
        subtitle: Text("Bitcoin"),
        leading: Image.network('https://i.mickle.tech/test/btc.png', width: 30, height: 30,),
        onTap: ()=>_gotoDetail(context, coin_name_btc),
      ),

      ListTile(
        title: Text(
          "ETH", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
        subtitle: Text("Ethereum"),
        leading: Image.network('https://i.mickle.tech/test/eth.png', width: 30, height: 30,),
        onTap: ()=>_gotoDetail(context, coin_name_eth),
      ),

      ListTile(
        title: Text(
          "EOS", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
        subtitle: Text("EOS"),
        leading: Image.network('https://i.mickle.tech/test/eos.png', width: 30, height: 30,),
        onTap: ()=>_gotoDetail(context, coin_name_eos),
      ),

    ];

    return Scaffold(
      appBar: new AppBar(title: new Text('各种链'),),
      body: Center(child: ListView(
      children: ListTile.divideTiles(context: context, tiles: list)
          .toList(),),),);
//    return Scaffold(body: Center(child: ListView(children: list,),),);
  }
}

_gotoDetail(BuildContext context, String coinName) {
  //静态路由不能传递参数
//  Navigator.of(context).pushNamed('/coin_detail');
  Navigator.push(context, MaterialPageRoute(builder:(context) => CoinDetailPage(coinName)));
}



