import 'chain_info_listener.dart';
import 'package:async/async.dart';
import 'chain_info_util.dart' as util;
import 'package:http/http.dart';
import 'chain_const.dart' as chainConst;
import 'dart:convert';

class ChainInfo{
  int chainType;
  String height;

  ChainInfo(this.chainType, this.height);
}

class BTCChainInfo extends ChainInfo{
  String peerCount;
  String unConfirmCount;
  String feeMax;
  String feeMin;
  String feeMedium;

  BTCChainInfo(int chainType, String height):super(chainType, height);
}

class EOSChainInfo extends ChainInfo{
  String producer;
  String version;

  EOSChainInfo(int chainType, String height):super(chainType, height);
}

Set<ChainInfoListener> _mListeners = Set();
RestartableTimer _timer;

EOSChainInfo mEosChainInfo;
BTCChainInfo mBTCChainInfo;
ChainInfo mETHChainInfo;

void startChainInfoListening(ChainInfoListener listener){
  _mListeners.add(listener);

  //初始化一下
  if (null != mBTCChainInfo){
    listener.onBTCInfoGet(mBTCChainInfo);
  }
  if (null != mETHChainInfo){
    listener.onETHInfoGet(mETHChainInfo);
  }
  if (null != mEosChainInfo){
    listener.onEOSInfoGet(mEosChainInfo);
  }

  if (null == _timer){
    _timer = new RestartableTimer(new Duration(seconds:5), _doGetChainInfo);
  }
}

void stopChainInfoListening(ChainInfoListener listener){
  _mListeners.remove(listener);
}

int count = 0;
void _doGetChainInfo(){
  util.getEOSInfo((Response response)=>_chainInfoGet(chainConst.chain_eos, response));

  //btc eth request limit  200 per hour
  if (0 == count%12){
    util.getETHInfo((Response response)=>_chainInfoGet(chainConst.chain_eth, response));
    util.getBTCInfo((Response response)=>_chainInfoGet(chainConst.chain_btc, response));
  }
  count++;

  if (null != _timer){
    _timer.reset();
  }
}

void _chainInfoGet(int type, Response response){
  Map<String, dynamic> map = json.decode(response.body);
  String blockNum;
  switch(type){
    case chainConst.chain_btc:
      blockNum = map['height'].toString();
      _mListeners.forEach((listener){
        BTCChainInfo info = new BTCChainInfo(chainConst.chain_btc, blockNum);
        info.peerCount = map['peer_count'].toString();
        info.unConfirmCount = map['unconfirmed_count'].toString();
        info.feeMax = map['high_fee_per_kb'].toString();
        info.feeMin = map['low_fee_per_kb'].toString();
        info.feeMedium = map['medium_fee_per_kb'].toString();
        listener.onBTCInfoGet(info);

        mBTCChainInfo = info;
      });
      break;
    case chainConst.chain_eth:
      blockNum = map['height'].toString();
      _mListeners.forEach((listener){
        BTCChainInfo info = new BTCChainInfo(chainConst.chain_eth, blockNum);
        info.peerCount = map['peer_count'].toString();
        info.unConfirmCount = map['unconfirmed_count'].toString();
        info.feeMax = map['high_gas_price'].toString();
        info.feeMin = map['low_gas_price'].toString();
        info.feeMedium = map['medium_gas_price'].toString();
        listener.onETHInfoGet(info);

        mETHChainInfo = info;
      });
      break;
    case chainConst.chain_eos:
      blockNum = map['head_block_num'].toString();
      _mListeners.forEach((listener){
        EOSChainInfo info = new EOSChainInfo(chainConst.chain_eos, blockNum);
        info.producer = map['head_block_producer'];
        info.version = map['server_version_string'];
        listener.onEOSInfoGet(info);

        mEosChainInfo = info;
      });
      break;
  }
}



