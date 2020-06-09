import 'dart:io';
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'USD';

  String bitcoinRateText = '1 BTC = ? USD';
  String ethereumRateText = '1 ETH = ? USD';
  String litecoinRateText = '1 LTC = ? USD';

  @override
  void initState() {
    super.initState();
    updateExchangeRates();
  }

  void updateExchangeRates() async {
    var bitcoinRate = await updateRate('BTC');
    var ethereumRate = await updateRate('ETH');
    var litecoinRate = await updateRate('LTC');
    setState(() {
      bitcoinRateText = bitcoinRate;
      ethereumRateText = ethereumRate;
      litecoinRateText = litecoinRate;
    });
  }

  Future<String> updateRate(String currency) async {
    var exchangeData =
        await coinData.getExchangeRateData(currency, selectedCurrency);
    double exchangeRate = exchangeData['rate'];
    return '1 $currency = ${exchangeRate.toInt()} $selectedCurrency';
  }

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
          updateExchangeRates();
        });
      },
    );
  }

  CupertinoPicker iOSCupertinoPicker() {
    List<Text> cupertinoPickerItems = [];

    for (String currency in currenciesList) {
      cupertinoPickerItems.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateExchangeRates();
        });
      },
      children: cupertinoPickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      bitcoinRateText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      ethereumRateText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      litecoinRateText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isIOS ? iOSCupertinoPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
