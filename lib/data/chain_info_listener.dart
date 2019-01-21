import 'chain_info.dart';

abstract class ChainInfoListener {
  void onBTCInfoGet(ChainInfo info);

  void onETHInfoGet(ChainInfo info);

  void onEOSInfoGet(ChainInfo info);
}
