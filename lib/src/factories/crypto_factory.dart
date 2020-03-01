import 'package:crypto_app/src/interfaces/crypto_repository.dart';
import 'package:crypto_app/src/models/crypto.dart';

class CryptoFactory implements CryptoRepository {
  @override
  Future<List<Crypto>> fetchCurrencies() {
    return Future.value(currencies);
  }
}

// dummy data
var currencies = <Crypto>[
  Crypto(
      name: 'Bitcoin',
      symbol: 'BTC',
      priceUsd: '8679',
      percentChange1h: '-0.56'),
  Crypto(
      name: 'Ethereum',
      symbol: 'ETH',
      priceUsd: '230.85',
      percentChange1h: '-0.16'),
  Crypto(
      name: 'Tether',
      symbol: 'USDT',
      priceUsd: '1.002',
      percentChange1h: '0.07'),
];
