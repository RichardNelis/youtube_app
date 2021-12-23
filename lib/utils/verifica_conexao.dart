import 'package:connectivity/connectivity.dart';

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