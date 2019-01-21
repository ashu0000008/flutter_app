import 'package:flutter/material.dart';

import 'data/chain_info.dart';
import 'data/chain_info_listener.dart';
import 'data/chain_const.dart';

class CoinDetailPage extends StatefulWidget {
  int type;

  CoinDetailPage(this.type);

  @override
  State createState() {
    return new _CoinDetailPage(type);
  }
}

class _CoinDetailPage extends State<CoinDetailPage>
    implements ChainInfoListener {
  int type;
  String coinName;
  String blockNum = "";

  List<Widget> list = [];

  _CoinDetailPage(int type){
    this.type = type;
    switch(type){
      case chain_btc:
        coinName = "btc";
        break;
      case chain_eth:
        coinName = "eth";
        break;
      case chain_eos:
        coinName = "eos";
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {


    String ico = 'https://i.mickle.tech/test/' + coinName + '.png';
    return Scaffold(
      appBar: new AppBar(
        title: new Text(coinName.toUpperCase() + " 节点信息"),
        leading: new Image.network(
          ico,
          width: 20,
          height: 20,
        ),
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
    startChainInfoListening(this);
  }

  @override
  void onBTCInfoGet(ChainInfo info) {
    if (type != info.chainType){
      return;
    }

    if (mounted){
      setState(() {
        blockNum = info.height;
        list.clear();
        list.add(InfoItem('最新块高', blockNum.toString(),),);

        BTCChainInfo btcInfo = info;
        list.add(InfoItem('节点个数', btcInfo.peerCount,),);
        list.add(InfoItem('未确认交易个数', btcInfo.unConfirmCount,),);
        list.add(InfoItem('矿工费（高）', btcInfo.feeMax,),);
        list.add(InfoItem('矿工费（中）', btcInfo.feeMedium,),);
        list.add(InfoItem('矿工费（低）', btcInfo.feeMin,),);
      });
    }
  }

  @override
  void onETHInfoGet(ChainInfo info) {
    if (type != info.chainType){
      return;
    }

    if (mounted){
      setState(() {
        blockNum = info.height;
        list.clear();
        list.add(InfoItem('最新块高', blockNum.toString(),),);

        BTCChainInfo btcInfo = info;
        list.add(InfoItem('节点个数', btcInfo.peerCount,),);
        list.add(InfoItem('未确认交易个数', btcInfo.unConfirmCount,),);
        list.add(InfoItem('矿工费（高）', btcInfo.feeMax,),);
        list.add(InfoItem('矿工费（中）', btcInfo.feeMedium,),);
        list.add(InfoItem('矿工费（低）', btcInfo.feeMin,),);
      });
    }
  }

  @override
  void onEOSInfoGet(ChainInfo info) {
    if (type != info.chainType){
      return;
    }

    if (mounted){
      setState(() {
        EOSChainInfo eosInfo = info;
        blockNum = info.height;

        list.clear();
        list.add(InfoItem('最新块高', blockNum.toString(),),);
        list.add(InfoItem('生产者', eosInfo.producer,),);
        list.add(InfoItem('节点版本', eosInfo.version,),
        );
      });
    }
  }

  @override
  void dispose() {
    stopChainInfoListening(this);
    super.dispose();
  }
}

class InfoItem extends StatelessWidget {
  String name;
  String value;

  InfoItem(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            name,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
