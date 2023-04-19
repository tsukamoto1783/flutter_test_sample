import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test_sample/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Mockitoパッケージを使用して、MockClientを自動生成する。
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('httpの呼出が正常に成功した場合、取得データを返却する', () async {
      // MockClientインスタンスの作成(モックオブジェクト)
      final client = MockClient();

      // client.getが呼び出されたときに、成功したレスポンスを返すように設定。
      // clientは、http.Clientをモックした、MockClientインスタンスであるため、
      // .getをしても実際のAPIアクセスは行わず、デフォルトだとnullを返す。
      // そこで、when().thenAnswer()で、指定の戻り値を返すように設定する。（スタブ化）
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      // fetchAlbum関数を実行し、戻り値がAlbum型のインスタンスであることを確認する
      // fetchAlbum関数内の、client.get部分は、先ほど振る舞いを指定した通りとなる。
      expect(await fetchAlbum(client), isA<Album>());
    });

    test('httpの呼び出しがエラーで完了した場合、例外を投げる', () {
      final client = MockClient();

      // MockClientインスタンスを使用し、.getをすると失敗したレスポンスを返すように設定。
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
