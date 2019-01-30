import 'package:flutter/material.dart';
import 'data/eos_ws.dart';
import 'app_const.dart';
import 'dart:convert';

class WSTestPage extends StatefulWidget {

  String _account;

  WSTestPage(this._account);

  @override
  State createState() {
    return new _WSTestPage(_account);
  }
}

class _WSTestPage extends State<WSTestPage>{
  WSTest ws = new WSTest();
  String _account;
  List<Widget> list = [];
  List<OneTransaction> mTxs = [];

  _WSTestPage(this._account);

  @override
  Widget build(BuildContext context) {

    String title = "账号";
    switch(_account){
      case eos_account_abcc:
        title = "abcc账号";
        break;
      case eos_account_binance:
        title = "币安账号";
        break;
      case eos_account_huobi:
        title = "火币账号";
        break;
      case eos_account_okex:
        title = "ok账号";
        break;
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text(title+"------total:"+list.length.toString()),
      ),
      body: Center(
        child: new ListView(
          itemExtent: 50,
          children:
          ListTile.divideTiles(context: context, tiles: list).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ws.initWS(_account, (String message){
      Map msgMap = jsonDecode(message);
      try{
        Map tranferData = msgMap['data']['actions'][0]['data'];
        if (null != tranferData){
          onTransferReceived(tranferData);
        }
      }catch(Exception){
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    ws.unInitWS(_account);
    ws = null;
  }

  void onTransferReceived(Map data){
    OneTransaction transaction = new OneTransaction(data['from'], data['to'], data['quantity']);
    mTxs.insert(0, transaction);

    setState(() {
      list.clear();
      for(OneTransaction tx in mTxs){
        list.add(new ListTile(title: Text("From:"+tx.from),
          subtitle: Text("To:"+tx.to),
          trailing: Text(tx.amount),
        ));
      }
    });
  }

}


class OneTransaction{
  String from;
  String to;
  String amount;

  OneTransaction(this.from, this.to, this.amount);

}