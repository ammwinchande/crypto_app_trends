import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage({Key key, this.currencies}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> _colors = [Colors.blue, Colors.red, Colors.green];

  @override
  void initState() {
    super.initState();
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
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final Color color = _colors[index % _colors.length];

                return itemTile(currency: currency, color: color);
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding itemTile({Map currency, Color color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(currency['symbol']),
          radius: 50,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            currency['name'].toString().toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: subTitleText(
          priceUsd: currency['price_usd'] + '\n',
          percentage: currency['percent_change_1h'],
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
}
