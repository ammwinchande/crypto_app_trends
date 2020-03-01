import 'package:crypto_app/src/api/crypto_data.dart';
import 'package:crypto_app/src/factories/crypto_factory.dart';
import 'package:crypto_app/src/interfaces/crypto_repository.dart';

enum Flavor { FACTORY, API }

class Injector {
  static final Injector _singleton = new Injector._internals();
  static Flavor _flavor;

  factory Injector() {
    return _singleton;
  }

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  Injector._internals();

  // select repository based on flavor
  CryptoRepository get cryptoRepository {
    switch (_flavor) {
      case Flavor.FACTORY:
        return CryptoFactory();
      default:
        return CryptoData();
    }
  }
}
