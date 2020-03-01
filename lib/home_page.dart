import 'package:crypto_app/src/models/crypto.dart';
import 'package:crypto_app/src/presenters/contracts/crypto_list_view_contract.dart';
import 'package:crypto_app/src/presenters/crypto_list_presenter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract {
  CryptoListPresenter _cryptoListPresenter;

  bool _isLoading;
  List<Crypto> _currencies;
  final List<Color> _colors = [Colors.blue, Colors.red, Colors.green];

  _HomePageState() {
    _cryptoListPresenter = new CryptoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _cryptoListPresenter.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Currency'),
      ),
      body: cryptoWidget(),
    );
  }

  Container cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Flexible(
                  child: ListView.builder(
                    itemCount: _currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Crypto currency = _currencies[index];
                      final Color color = _colors[index % _colors.length];

                      return itemTile(currency: currency, color: color);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Padding itemTile({Crypto currency, Color color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(currency.symbol),
          radius: 50,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            currency.name.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: subTitleText(
          priceUsd: currency.priceUsd + '\n',
          percentage: currency.percentChange1h,
        ),
      ),
    );
  }

  subTitleText({String priceUsd, String percentage}) {
    TextSpan priceText = new TextSpan(
      text: '\$$priceUsd',
      style: TextStyle(color: Colors.black),
    );
    String percentageChangeIn1hr = '1 hour: $percentage%\n';
    TextSpan percentageChangeText;
    if (double.parse(percentage) > 0) {
      percentageChangeText = TextSpan(
        text: percentageChangeIn1hr,
        style: TextStyle(color: Colors.green),
      );
    } else {
      percentageChangeText = TextSpan(
        text: percentageChangeIn1hr,
        style: TextStyle(color: Colors.red),
      );
    }

    return RichText(
      text: TextSpan(children: [priceText, percentageChangeText]),
    );
  }

  @override
  void onLoadComplete(List<Crypto> cryptos) {
    setState(() {
      _currencies = cryptos;
      print(_currencies);
    });
    _isLoading = false;
  }

  @override
  void onLoadError() {
    // TODO: implement onLoadError
  }
}
