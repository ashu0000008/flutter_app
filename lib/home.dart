import 'package:flutter/material.dart';

import 'data/chain_const.dart';
import 'data/chain_info.dart';
import 'data/chain_info_listener.dart';
import 'page_coin_detail.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements ChainInfoListener {
  Map<int, ChainInfo> mData = new Map();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    startChainInfoListening(this);
  }

  @override
  void dispose() {
    stopChainInfoListening(this);
    super.dispose();
  }

  @override
  void onEOSInfoGet(ChainInfo info) {
    setState(() {
      if (mData.containsKey(chain_eos)){
        mData[chain_eos] = info;
      }else{
        mData.putIfAbsent(chain_eos, () => info);
      }
    });
  }

  @override
  void onETHInfoGet(ChainInfo info) {
    setState(() {
      if (mData.containsKey(chain_eth)){
        mData[chain_eth] = info;
      }else{
        mData.putIfAbsent(chain_eth, () => info);
      }
    });
  }

  @override
  void onBTCInfoGet(ChainInfo info) {
    setState(() {
      if (mData.containsKey(chain_btc)){
        mData[chain_btc] = info;
      }else{
        mData.putIfAbsent(chain_btc, () => info);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> list = [];
    list.add(ListTile(
      title: Text(
        "BTC",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      subtitle: Text("Bitcoin"),
      leading: Image.network(
        'https://i.mickle.tech/test/btc.png',
        width: 30,
        height: 30,
      ),
      trailing:
      Text(mData[chain_btc] == null ? '0' : mData[chain_btc].height),
      onTap: () => _gotoDetail(context, chain_btc),
    ));
    list.add(ListTile(
      title: Text(
        "ETH",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      subtitle: Text("Ethereum"),
      leading: Image.network(
        'https://i.mickle.tech/test/eth.png',
        width: 30,
        height: 30,
      ),
      trailing:
      Text(mData[chain_eth] == null ? '0' : mData[chain_eth].height),
      onTap: () => _gotoDetail(context, chain_eth),
    ));
    list.add(ListTile(
      title: Text(
        "EOS",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      subtitle: Text("EOS"),
      leading: Image.network(
        'https://i.mickle.tech/test/eos.png',
        width: 30,
        height: 30,
      ),
      trailing:
      Text(mData[chain_eos] == null ? '0' : mData[chain_eos].height),
      onTap: () => _gotoDetail(context, chain_eos),
    ));

    return Scaffold(
      appBar: new AppBar(
        title: new Text('各种链'),
      ),
      body: Center(
        child: ListView(
          children:
              ListTile.divideTiles(context: context, tiles: list).toList(),
        ),
      ),
    );
  }
}

_gotoDetail(BuildContext context, int type) {
  //静态路由不能传递参数
//  Navigator.of(context).pushNamed('/coin_detail');
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CoinDetailPage(type)));
}
