import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _subscription;

  ConnectivityProvider() {
    init();
  }

  Future<void> init() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    _connectivityResult = result;
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityResult = result;
      notifyListeners();
    });
  }

  @override
  dispose() {
    _subscription.cancel();
    super.dispose();
  }

  ConnectivityResult get connectivityResult => _connectivityResult;

}