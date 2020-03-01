import 'package:crypto_app/src/models/crypto.dart';
import 'package:crypto_app/src/presenters/contracts/crypto_list_view_contract.dart';
import 'package:crypto_app/src/presenters/crypto_list_presenter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract {
  CryptoListPresenter _cryptoListPresenter;

  bool _isLoading;
  List<Crypto> _currencies;

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
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0 : 16,
      ),
      body: _cryptoWidget(),
    );
  }

  Container _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Flexible(
                  child: ListView.builder(
                    itemCount: _currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_currencies.isNotEmpty) {
                        _renderTiles(index: index);
                      }

                      return Center(child: Text('No Currency Data'));
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _renderTiles({int index}) {
    final Crypto currency = _currencies[index];
    var children = <Widget>[
      Padding(
        padding: EdgeInsets.all(10.0),
        child: _itemTile(currency: currency),
      ),
      Divider(height: 5.0),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Padding _itemTile({Crypto currency}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: FadeInImage(
          placeholder: AssetImage('assets/2.0x/stars.png'),
          image: NetworkImage(
            "https://cdn.jsdelivr.net/gh/atomiclabs/cryptocurrency-icons@9867bdb19da14e63ffbe63805298fa60bf255cdd/32@2x/icon/" +
                currency.symbol.toLowerCase() +
                "@2x.png",
          ),
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
    TextSpan priceText = TextSpan(
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
      _isLoading = false;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      _currencies = [];
      _isLoading = false;
    });
  }
}
