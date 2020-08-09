import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  static final Map<String, String> defaultCurrencyValue = {
    'BTC': '?',
    'ETH': '?',
    'LTC': '?',
  };

  Map<String, String> currencyValues = defaultCurrencyValue;

  void getData() async {
    try {
      setState(() => currencyValues = defaultCurrencyValue);

      var coins = await CoinData.getCoinData(selectedCurrency);

      setState(() => currencyValues = coins);
    } catch (e) {
      print(e);
    }
  }

  CupertinoPicker getPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(
        initialItem: 19,
      ),
      onSelectedItemChanged: (index) {
        selectedCurrency = currenciesList[index];
        getData();
      },
      children: currenciesList
          .map((e) => Text(
                e,
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
          .toList(),
    );
  }

  DropdownButton getDropdownButton() {
    return DropdownButton(
      value: selectedCurrency,
      items: currenciesList.map((String e) {
        return DropdownMenuItem<String>(
          child: Text(e),
          value: e,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                  cryptoCurrency: 'BTC',
                  selectedCurrencyValue: currencyValues['BTC'],
                  selectedCurrency: selectedCurrency),
              CryptoCard(
                  cryptoCurrency: 'ETH',
                  selectedCurrencyValue: currencyValues['ETH'],
                  selectedCurrency: selectedCurrency),
              CryptoCard(
                  cryptoCurrency: 'LTC',
                  selectedCurrencyValue: currencyValues['LTC'],
                  selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {@required this.cryptoCurrency,
      @required this.selectedCurrency,
      @required this.selectedCurrencyValue});

  final String cryptoCurrency;
  final String selectedCurrencyValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $selectedCurrencyValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
