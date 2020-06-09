import 'package:bitcoin_ticker/network_helper.dart';

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

const kApiKey = 'C9414AF9-83F0-4725-9F88-D110F40B4886';
const kApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getExchangeRateData(String from, String to) async {
    NetworkHelper networkHelper =
        NetworkHelper('$kApiUrl/$from/$to?apikey=$kApiKey');

    return await networkHelper.getData();
  }
}
