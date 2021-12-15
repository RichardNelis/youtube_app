import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/bloc/video_bloc.dart';

import 'bloc/favorite_bloc.dart';
import 'page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideoBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      dependencies: const [],
      child: const MaterialApp(
        title: 'Youtube APP',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
