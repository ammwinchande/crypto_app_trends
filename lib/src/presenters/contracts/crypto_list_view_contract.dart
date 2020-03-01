import 'package:crypto_app/src/models/crypto.dart';

abstract class CryptoListViewContract {
  void onLoadComplete(List<Crypto> cryptos);
  void onLoadError();
}
