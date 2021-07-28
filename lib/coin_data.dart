//import 'package:bitcoin_app/Services/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'D85C38C1-EA3C-4E1A-A382-9BF87A8FC324';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];


const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getBitCoinData(String Currency) async {
    Map<String,String> cryptoData = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$crypto/$Currency?apikey=$apiKey');
      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cryptoData[crypto] = data['rate'].toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoData;
  }

}
