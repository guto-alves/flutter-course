import 'dart:convert';

import 'package:http/http.dart' as http;

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

const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'CC663B9A-2405-4BF7-A514-9A691DCC836C';

class CoinData {
  static Future _getCoinData(String from, String to) async {
    var response = await http.get('$baseUrl/$from/$to?apikey=$apiKey');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rate'];
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String cryptoCurrency in cryptoList) {
      double price = await _getCoinData(cryptoCurrency, selectedCurrency);

      cryptoPrices[cryptoCurrency] = price.toStringAsFixed(0);
    }

    return cryptoPrices;
  }
}
