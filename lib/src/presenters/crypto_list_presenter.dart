import 'package:crypto_app/src/dependency_injection.dart';
import 'package:crypto_app/src/interfaces/crypto_repository.dart';
import 'package:crypto_app/src/presenters/contracts/crypto_list_view_contract.dart';

class CryptoListPresenter {
  CryptoListViewContract _cryptoListViewContract;
  CryptoRepository _cryptoRepository;

  CryptoListPresenter(this._cryptoListViewContract) {
    _cryptoRepository = Injector().cryptoRepository;
  }

  void loadCurrencies() {
    _cryptoRepository
        .fetchCurrencies()
        .then((crypto) => _cryptoListViewContract.onLoadComplete(crypto))
        .catchError((error) => _cryptoListViewContract.onLoadError());
  }
}
