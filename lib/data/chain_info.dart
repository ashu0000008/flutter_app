import 'package:http/http.dart' as http;

void getEOSInfo(var callback){
  http.get('https://api.eospark.com/v1/chain/get_info?apikey=a9564ebc3289b7a14551baf8ad5ec60a')
      .then((response)=>callback(response));
}