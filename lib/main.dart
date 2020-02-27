import 'dart:convert';

import 'package:crypto_app/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await getCurrencies();
  runApp(MyApp(
    currencies: currencies,
  ));
}

class MyApp extends StatefulWidget {
  final List currencies;
  @override
  MyApp({Key key, this.currencies}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: defaultTargetPlatform == TargetPlatform.iOS
            ? Colors.blueGrey
            : Colors.teal,
      ),
      home: HomePage(
        currencies: widget.currencies,
      ),
    );
  }
}

Future<List> getCurrencies() async {
  String url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
