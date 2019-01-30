import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:async/async.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter_app/app_const.dart';

@JsonSerializable()
class SubRequest{
  String msg_type;
  String name;

  SubRequest(this.msg_type, this.name);

  SubRequest.fromJson(Map<String, dynamic> json)
        : msg_type = json['msg_type'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'msg_type': msg_type,
        'name': name,
      };
}

class WSTest{
  IOWebSocketChannel channel;
  RestartableTimer timer;
  void initWS(String account, var callback){
    channel = IOWebSocketChannel.connect('wss://ws.eospark.com/v1/ws?apikey=ecbd7f756cc610b755542f639a4ee4bd');
    SubRequest subReq = new SubRequest("subscribe_account", account);
    channel.sink.add(jsonEncode(subReq));

    if (account == eos_account_binance){
      SubRequest subReq = new SubRequest("subscribe_account", eos_account_binance2);
      channel.sink.add(jsonEncode(subReq));
    }

    channel.stream.listen((message){
      print(message);
      Map msgMap = jsonDecode(message);
      if ('heartbeat' != msgMap['msg_type']){
        callback(message);
      }
    });
  }

  void unInitWS(String account){
    if (null != channel){
      SubRequest subReq = new SubRequest("unsubscribe_account", account);
      channel.sink.add(jsonEncode(subReq));
      timer = new RestartableTimer(new Duration(seconds:1), (){
        channel.sink.close(status.goingAway);
        channel = null;
        timer.cancel();
      });

    }
  }
}

