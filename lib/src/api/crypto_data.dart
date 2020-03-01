import 'dart:convert';

import 'package:crypto_app/src/console/fetch_exception.dart';
import 'package:crypto_app/src/interfaces/crypto_repository.dart';
import 'package:crypto_app/src/models/crypto.dart';
import 'package:http/http.dart' as http;

class CryptoData implements CryptoRepository {
  final String url = 'https://api.coinmarketcap.com/v1/ticker/';

  @override
  Future<List<Crypto>> fetchCurrencies() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List cryptoResponse = json.decode(response.body);
      return cryptoResponse.map((crypto) => Crypto.fromMap(crypto)).toList();
    } else {
      throw new FetchException(
        'An error occured: [Status Code: ${response.statusCode}]',
      );
    }
  }
}
