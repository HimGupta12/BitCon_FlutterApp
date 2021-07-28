import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurreny = 'AUD';
  String bitCoinValue = 'Error';

  Map<String,String> coinValues = {};

  void updateUI() async {
    try {
      var bitCoinDataVMap = await CoinData().getBitCoinData(selectedCurreny);
      // print(bitCoinData);
      setState(() {
        if (bitCoinDataVMap == null) {
          coinValues = {};
          return;
        }
        coinValues = bitCoinDataVMap;
        // print(bitCoinValue);
      });
    } catch (e) {
      print(e);
  }
  }

  Column createCrads() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      var card = CryptoCard(
        value: coinValues[crypto]!,
        cryptoCurrency: crypto,
        selectedCurrency: selectedCurreny,
      );
      cryptoCards.add(card);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cryptoCards,
    );
  }
  @override
  void initState() {
    super.initState();
    updateUI();
  }
  DropdownButton<String> androidDopdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String currency in currenciesList) {
      var newItem =  DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      onChanged: (value) {
        setState(() {
          selectedCurreny = value!;
          updateUI();
        });
      },
      value: selectedCurreny,
      items: dropdownItems,
    );
  }


  CupertinoPicker iOSPickerView() {
    List<Widget> dropdownItems = [];
    for(String currency in currenciesList) {
      var newItem =  Text(currency);
      dropdownItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurreny = currenciesList[selectedIndex];
          updateUI();
        });

      },
      children: dropdownItems,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          createCrads(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPickerView() : androidDopdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });
  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

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
           '1 $cryptoCurrency = $value $selectedCurrency',
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