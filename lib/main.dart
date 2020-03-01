import 'package:crypto_app/home_page.dart';
import 'package:crypto_app/src/dependency_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  Injector.configure(Flavor.API);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: defaultTargetPlatform == TargetPlatform.iOS
            ? Colors.blueGrey
            : Colors.teal,
      ),
      home: HomePage(),
    );
  }
}
