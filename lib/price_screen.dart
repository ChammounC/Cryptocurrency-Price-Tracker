import 'package:flutter/material.dart';
import 'package:cryptocurrency_price_tracker/coin_data.dart';
import 'dart:ui';

String apiKey = '2289F0E0-8EAE-4C37-9E8B-6EFBFB89ED34';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  String bitcoinValue = '?';
  String ethereumValue = '?';
  String litecoinValue = '?';

  void getData() async {
    try {
      double btcdata = await CoinData(currency:selectedCurrency!,crypto:'BTC').getCoinData();
      double ethdata = await CoinData(currency:selectedCurrency!,crypto:'ETH').getCoinData();
      double ltcdata = await CoinData(currency:selectedCurrency!,crypto:'LTC').getCoinData();
      setState(() {
        bitcoinValue = btcdata.toStringAsFixed(0);
        ethereumValue = ethdata.toStringAsFixed(0);
        litecoinValue = ltcdata.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }



  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              children: [
                CryptoButton(
                  crypto: 'BTC',
                  bitcoinValueInUSD: bitcoinValue,
                  selectedCurrency: selectedCurrency,
                ),
                CryptoButton(
                  crypto: 'ETH',
                  bitcoinValueInUSD: ethereumValue,
                  selectedCurrency: selectedCurrency,
                ),
                CryptoButton(
                  crypto: 'LTC',
                  bitcoinValueInUSD: litecoinValue,
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                  getData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoButton extends StatelessWidget {
  const CryptoButton({
    Key? key,
    required this.bitcoinValueInUSD,
    required this.selectedCurrency,
    required this.crypto,
  }) : super(key: key);

  final String bitcoinValueInUSD;
  final String? selectedCurrency;
  final String crypto;

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
            '1 $crypto = $bitcoinValueInUSD $selectedCurrency',
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
