class Crypto {
  String name;
  String symbol;
  String priceUsd;
  String percentChange1h;

  Crypto({this.name, this.symbol, this.priceUsd, this.percentChange1h});

  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        symbol = map['symbol'],
        priceUsd = map['price_usd'],
        percentChange1h = map['percentage_change_1h'];

  // factory Crypto.fromJson(Map<String, dynamic> map) {
  //   return Crypto(
  //     name: map['name'],
  //     symbol: map['symbol'],
  //     priceUsd: map['price_usd'],
  //     percentChange1h: map['percentage_change_1h'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'symbol': symbol,
  //     'price_usd': priceUsd,
  //     'percentage_change_1h': percentChange1h
  //   };
  // }
}
