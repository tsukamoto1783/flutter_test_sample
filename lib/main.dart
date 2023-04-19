import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// アルバムデータを取得する関数
Future<Album> fetchAlbum(http.Client client) async {
  // http.Clientを使って、外部APIにアクセスする。
  // ここではid=1のアルバムデータを取得する。
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // print(response.body);
    // print(jsonDecode(response.body));

    // サーバーから"200 OK"が返ってきた場合、Albumクラスのインスタンスを返す。
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // サーバーから"200 OK"が返ってこなかった場合、例外を投げる。
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  // 通常のコンストラクタ
  const Album({required this.userId, required this.id, required this.title});

  // ファクトリコンストラクタ
  // jsonデータの場合、わざわざ値を取り出してコンストラクタに渡さなくても、
  // このようにファクトリコンストラクタを使うことで、
  // より簡単にインスタンスを生成できる。（柔軟性、カスタマイズ性）
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  // 名前付きコンストラクタ
  // Album.test()
  //     : userId = 1,
  //       id = 2,
  //       title = "mock";
}

// APIから取得したアルバムデータを表示するだけの画面
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
