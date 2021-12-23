import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/page/offline_page.dart';
import 'package:youtube_app/utils/verifica_conexao.dart';

import 'home_page.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Connectivity _connectivity = Connectivity();

    return StreamBuilder<ConnectivityResult>(
      stream: _connectivity.onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.data != null && verificaConexao(snapshot.data!)) {
          return const HomePage();
        } else {
          return const OfflinePage();
        }
      },
    );
  }
}
