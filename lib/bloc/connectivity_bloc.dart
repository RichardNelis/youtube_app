import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityBloc implements BlocBase {
  final Connectivity _connectivity = Connectivity();

  final _connectivityController = BehaviorSubject<ConnectivityResult>();
  Stream get outConnectivity => _connectivityController.stream;

  ConnectivityBloc() {
    _connectivity.checkConnectivity().then(
          (value) => _connectivityController.sink.add(value),
        );

    _connectivity.onConnectivityChanged.listen((event) {
      _connectivityController.sink.add(event);
    });
  }

  bool verificaConexao(ConnectivityResult result) {
    bool connected = false;

    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        connected = true;
        break;
      case ConnectivityResult.none:
      default:
        connected = false;
        break;
    }

    return connected;
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
