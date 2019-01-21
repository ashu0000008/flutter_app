import 'package:http/http.dart' as http;

void getEOSInfo(var callback){
  http.get('https://api.eospark.com/v1/chain/get_info?apikey=a9564ebc3289b7a14551baf8ad5ec60a')
      .then((response)=>callback(response));
}

void getBTCInfo(var callback){
  http.get("https://api.blockcypher.com/v1/btc/main").then((response)=>callback(response));
}

void getETHInfo(var callback){
  http.get("https://api.blockcypher.com/v1/eth/main").then((response)=>callback(response));
}


