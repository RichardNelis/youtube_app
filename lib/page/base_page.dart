import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/bloc/connectivity_bloc.dart';
import 'package:youtube_app/page/offline_page.dart';

import 'home_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late bool _dialogOpen;
  late ConnectivityBloc _blocConnectivy;

  @override
  void initState() {
    super.initState();

    _dialogOpen = false;
    _blocConnectivy = BlocProvider.getBloc<ConnectivityBloc>();

    _blocConnectivy.outConnectivity.listen((event) async {
      if (!_blocConnectivy.verificaConexao(event)) {
        await showDialog(
          context: context,
          builder: (context) {
            _dialogOpen = true;
            return const OfflinePage();
          },
        );
      }

      if (_dialogOpen) {
        _dialogOpen = false;
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
