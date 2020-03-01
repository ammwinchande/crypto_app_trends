import 'package:crypto_app/src/models/crypto.dart';

abstract class CryptoRepository {
  /// Fetch currencies from API
  ///
  /// @return List of curries following the Crypto Model
  Future<List<Crypto>> fetchCurrencies();
}
