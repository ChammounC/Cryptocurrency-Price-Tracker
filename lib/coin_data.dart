import 'package:http/http.dart' as http;
import 'dart:convert';
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

const coinAPIURL ='https://rest.coinapi.io/v1/exchangerate';
const apiKey = '2289F0E0-8EAE-4C37-9E8B-6EFBFB89ED34';

class CoinData{
  final String currency;
  final String crypto;
  CoinData({required this.currency,required this.crypto});

  Future getCoinData() async{
    var requestURL = Uri.parse('$coinAPIURL/$crypto/$currency?apikey=$apiKey');
    http.Response response = await http.get(requestURL);

    if(response.statusCode==200){
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    }else{
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}