import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/utils/constants.dart';

class DataSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List<String>>(
        future: suggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                String texto = snapshot.data![index];

                return ListTile(
                  title: Text(texto),
                  leading: const Icon(Icons.play_arrow),
                  onTap: () {
                    close(context, texto);
                  },
                );
              },
            );
          }
        },
      );
    }
  }

  Future<List<String>> suggestions(String search) async {
    List<String> sugestoes;

    Dio dio = Dio();
    Response response = await dio.get(urlSUGGESTIONS + search);

    if (response.statusCode == 200) {
      sugestoes = List<String>.from(
        response.data[1].map(
          (map) => map[0],
        ),
      );
    } else {
      throw Exception("Erro");
    }

    return sugestoes;
  }
}
